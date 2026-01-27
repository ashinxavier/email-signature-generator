# Supabase Setup Guide

Quick guide to set up your Supabase database for the Email Signature Generator.

## Step 1: Run the SQL Schema

1. Open your Supabase Dashboard: https://supabase.com/dashboard/project/hseuvuwxuehuzhiiqhyh
2. Click on **SQL Editor** in the left sidebar
3. Click **New Query**
4. Open the file `supabase-setup.sql` from your project folder
5. Copy all the SQL code
6. Paste it into the SQL Editor
7. Click **Run** (or press Ctrl+Enter)

You should see a success message. This creates:
- ✅ `profiles` table
- ✅ `signatures` table
- ✅ Row Level Security policies
- ✅ Automatic triggers

## Step 2: Create Storage Bucket

1. In your Supabase Dashboard, click **Storage** in the left sidebar
2. Click **Create a new bucket**
3. Enter bucket name: `logos`
4. Toggle **Public bucket** to **ON**
5. Click **Create bucket**

## Step 3: Add Storage Policies

1. Click on the **logos** bucket
2. Click the **Policies** tab
3. Click **New Policy** 

Add these 4 policies:

### Policy 1: Upload
- **Name:** Authenticated users can upload logos
- **Allowed operation:** INSERT
- **Policy definition:**
```sql
(bucket_id = 'logos' AND auth.role() = 'authenticated')
```

### Policy 2: View
- **Name:** Anyone can view logos
- **Allowed operation:** SELECT
- **Policy definition:**
```sql
(bucket_id = 'logos')
```

### Policy 3: Delete
- **Name:** Users can delete own logos
- **Allowed operation:** DELETE
- **Policy definition:**
```sql
(bucket_id = 'logos' AND (storage.foldername(name))[1] = auth.uid()::text)
```

### Policy 4: Update
- **Name:** Users can update own logos
- **Allowed operation:** UPDATE
- **Policy definition:**
```sql
(bucket_id = 'logos' AND (storage.foldername(name))[1] = auth.uid()::text)
```

## Step 4: Enable Email Auth (if not already enabled)

1. Go to **Authentication** > **Providers**
2. Make sure **Email** is enabled
3. Configure email settings if needed

## Verification

To verify everything is set up:

1. Go to **Table Editor** - you should see `profiles` and `signatures` tables
2. Go to **Storage** - you should see the `logos` bucket
3. Click on `logos` bucket > **Policies** - you should see 4 policies

## Done! 

Your Supabase backend is now ready. The application will automatically connect using the credentials you provided.
