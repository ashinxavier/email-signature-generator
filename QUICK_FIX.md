# 🚨 Quick Fix Steps

## The Problem

Your app at https://email-signature-generator-theta.vercel.app/ isn't working because:

1. ❌ **Invalid Supabase anon key** in `index.html` (line 981)
2. ❌ **Vercel domain not configured** in Supabase

---

## Step 1: Get Your Supabase Anon Key (1 minute)

1. Open: https://supabase.com/dashboard/project/hseuvuwxuehuzhiiqhyh/settings/api

2. Copy the **"anon public"** key (starts with `eyJ...`)

---

## Step 2: Update index.html

Open `index.html` and replace line 981:

**BEFORE:**
```javascript
const SUPABASE_ANON_KEY = 'sb_publishable_V7-xqqeLNbkA_7OR2wAGwg_vPJXrtwm';
```

**AFTER:**
```javascript
const SUPABASE_ANON_KEY = 'YOUR_KEY_HERE'; // Paste the eyJ... key you just copied
```

---

## Step 3: Configure Supabase for Vercel (2 minutes)

### A. CORS Settings
1. Go to: https://supabase.com/dashboard/project/hseuvuwxuehuzhiiqhyh/settings/api
2. Find "CORS (Cross-Origin Resource Sharing)"
3. Add: `https://email-signature-generator-theta.vercel.app`

### B. Auth URLs
1. Go to: https://supabase.com/dashboard/project/hseuvuwxuehuzhiiqhyh/auth/url-configuration
2. Set **Site URL**: `https://email-signature-generator-theta.vercel.app`
3. Add **Redirect URL**: `https://email-signature-generator-theta.vercel.app/**`

---

## Step 4: Redeploy

```bash
git add index.html
git commit -m "Fix: Add correct Supabase anon key"
git push
```

Vercel will auto-deploy in ~30 seconds! 🚀

---

## Test

Visit your site and:
1. Click upload icon - should work ✅
2. Click Sign In - should work ✅

Done! 🎉
