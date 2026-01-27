-- Email Signature Generator - Supabase Database Setup
-- Run this SQL in your Supabase SQL Editor

-- Enable UUID extension if not already enabled
create extension if not exists "uuid-ossp";

-- =============================================
-- PROFILES TABLE
-- =============================================

create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  email text,
  full_name text,
  avatar_url text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable Row Level Security
alter table public.profiles enable row level security;

-- Drop existing policies if they exist
drop policy if exists "Users can view own profile" on public.profiles;
drop policy if exists "Users can update own profile" on public.profiles;
drop policy if exists "Users can insert own profile" on public.profiles;

-- Policies for profiles
create policy "Users can view own profile"
  on public.profiles for select
  using ( auth.uid() = id );

create policy "Users can insert own profile"
  on public.profiles for insert
  with check ( auth.uid() = id );

create policy "Users can update own profile"
  on public.profiles for update
  using ( auth.uid() = id );

-- =============================================
-- SIGNATURES TABLE
-- =============================================

create table if not exists public.signatures (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users on delete cascade not null,
  title text not null, -- User-given name for the signature
  name text not null,
  job_title text,
  company text,
  website text,
  phone text,
  twitter text,
  logo_url text, -- Supabase Storage URL
  is_default boolean default false,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable Row Level Security
alter table public.signatures enable row level security;

-- Drop existing policies if they exist
drop policy if exists "Users can view own signatures" on public.signatures;
drop policy if exists "Users can insert own signatures" on public.signatures;
drop policy if exists "Users can update own signatures" on public.signatures;
drop policy if exists "Users can delete own signatures" on public.signatures;

-- Policies for signatures
create policy "Users can view own signatures"
  on public.signatures for select
  using ( auth.uid() = user_id );

create policy "Users can insert own signatures"
  on public.signatures for insert
  with check ( auth.uid() = user_id );

create policy "Users can update own signatures"
  on public.signatures for update
  using ( auth.uid() = user_id );

create policy "Users can delete own signatures"
  on public.signatures for delete
  using ( auth.uid() = user_id );

-- Indexes for better performance
drop index if exists signatures_user_id_idx;
drop index if exists signatures_created_at_idx;

create index signatures_user_id_idx on public.signatures(user_id);
create index signatures_created_at_idx on public.signatures(created_at desc);

-- =============================================
-- STORAGE BUCKET & POLICIES
-- =============================================

-- Create logos bucket (run this in SQL editor, then create bucket manually if it fails)
-- Note: You may need to create the bucket manually in the Supabase dashboard
-- Storage > Create bucket > Name: "logos" > Public bucket: ON

-- Storage policies (apply these after creating the bucket)
-- These allow authenticated users to upload and delete their own logos
-- And allow anyone to view logos (since it's a public bucket)

-- IMPORTANT: After creating the 'logos' bucket in the Supabase dashboard,
-- go to Storage > logos > Policies and add these policies:

-- Policy 1: Allow authenticated users to upload
-- Name: "Authenticated users can upload logos"
-- Allowed operation: INSERT
-- Policy definition:
-- (bucket_id = 'logos' AND auth.role() = 'authenticated')

-- Policy 2: Allow public reads
-- Name: "Anyone can view logos"  
-- Allowed operation: SELECT
-- Policy definition:
-- (bucket_id = 'logos')

-- Policy 3: Allow users to delete own logos
-- Name: "Users can delete own logos"
-- Allowed operation: DELETE
-- Policy definition:
-- (bucket_id = 'logos' AND (storage.foldername(name))[1] = auth.uid()::text)

-- Policy 4: Allow users to update own logos
-- Name: "Users can update own logos"
-- Allowed operation: UPDATE
-- Policy definition:
-- (bucket_id = 'logos' AND (storage.foldername(name))[1] = auth.uid()::text)

-- =============================================
-- TRIGGERS FOR UPDATED_AT
-- =============================================

-- Function to update updated_at timestamp
create or replace function public.handle_updated_at()
returns trigger as $$
begin
  new.updated_at = timezone('utc'::text, now());
  return new;
end;
$$ language plpgsql security definer;

-- Trigger for profiles
drop trigger if exists set_updated_at on public.profiles;
create trigger set_updated_at
  before update on public.profiles
  for each row
  execute function public.handle_updated_at();

-- Trigger for signatures
drop trigger if exists set_updated_at on public.signatures;
create trigger set_updated_at
  before update on public.signatures
  for each row
  execute function public.handle_updated_at();

-- =============================================
-- FUNCTION TO CREATE PROFILE ON SIGNUP
-- =============================================

-- Function to create profile after user signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email, full_name)
  values (
    new.id,
    new.email,
    new.raw_user_meta_data->>'full_name'
  );
  return new;
end;
$$ language plpgsql security definer;

-- Trigger to create profile on signup
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row
  execute function public.handle_new_user();

-- =============================================
-- SETUP COMPLETE
-- =============================================

-- Next steps:
-- 1. Create the 'logos' storage bucket in Supabase dashboard:
--    Storage > Create bucket > Name: "logos" > Public: ON
-- 
-- 2. Add storage policies (see comments above)
--
-- 3. Test the setup by signing up a user and creating a signature
