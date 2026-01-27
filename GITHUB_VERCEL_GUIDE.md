# 📤 Push to GitHub & Connect to Vercel

## ✅ Git Repository Initialized!

Your local Git repository is ready. Here's how to push it to GitHub and connect with Vercel.

---

## Step 1: Create GitHub Repository

1. **Go to GitHub**: https://github.com/new
2. **Create a new repository**:
   - Repository name: `email-signature-generator` (or your choice)
   - Description: "Professional email signature generator with Supabase"
   - **Keep it Public** (or Private if you prefer)
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
3. **Click "Create repository"**

---

## Step 2: Push to GitHub

After creating the repository, GitHub will show you the commands. Run these in your terminal:

```bash
# Add GitHub as remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/email-signature-generator.git

# Push your code
git push -u origin main
```

**Example:**
```bash
git remote add origin https://github.com/johndoe/email-signature-generator.git
git push -u origin main
```

GitHub will ask for your credentials:
- Username: Your GitHub username
- Password: Use a **Personal Access Token** (not your password)
  - Create one at: https://github.com/settings/tokens
  - Select scopes: `repo`

---

## Step 3: Connect to Vercel

### Option A: Automatic GitHub Import (Recommended)

1. **Go to Vercel**: https://vercel.com/new
2. **Sign up/Login** with your GitHub account
3. **Import your repository**:
   - Click "Import Git Repository"
   - Find `email-signature-generator` in the list
   - Click "Import"
4. **Configure (optional)**:
   - Project name: Auto-filled
   - Framework Preset: Other (auto-detected)
   - Root Directory: `./`
   - Build Command: Leave blank (static site)
   - Output Directory: Leave blank
5. **Click "Deploy"**

🎉 **Done!** You now have continuous deployment. Every push to `main` will automatically deploy.

### Option B: Manual Import (Vercel CLI)

```bash
# Login to Vercel
vercel login

# Link to GitHub repo
vercel --prod
```

Follow the prompts to connect your GitHub repository.

---

## Step 4: Configure Supabase for Production

After deployment, update your Supabase settings:

1. **Get your Vercel URL** from the deployment (e.g., `https://email-signature-generator.vercel.app`)

2. **Update Supabase CORS**:
   - Supabase Dashboard → Settings → API
   - Add to "CORS Allowed Origins":
     ```
     https://email-signature-generator.vercel.app
     ```

3. **Update Authentication URLs**:
   - Supabase Dashboard → Authentication → URL Configuration
   - Site URL: `https://email-signature-generator.vercel.app`
   - Add Redirect URL: `https://email-signature-generator.vercel.app/**`

---

## Step 5: Test Your Deployment

Visit your live site and test:
- ✅ Page loads correctly
- ✅ Sign up/Sign in works
- ✅ Signature generation works
- ✅ Saving signatures works
- ✅ Logo upload works

---

## 🔄 Future Updates

Now that everything is connected, deploying updates is super easy:

```bash
# Make your changes
git add .
git commit -m "Your update message"
git push

# Vercel automatically deploys! 🚀
```

---

## 🎨 Optional: Add a Custom Domain

1. Go to Vercel Dashboard → Your Project → Settings → Domains
2. Add your custom domain
3. Follow DNS configuration instructions
4. Update Supabase CORS and Auth URLs with your custom domain

---

## 📊 Monitor Your Deployment

- **Vercel Dashboard**: View deployment status, logs, and analytics
- **GitHub**: See commits that triggered deployments
- **Supabase Dashboard**: Monitor database and auth activity

---

## 🆘 Need Help?

**Common Issues:**

- **Authentication fails:** Check Supabase Auth URLs
- **CORS errors:** Verify Vercel URL in Supabase CORS settings
- **Deployment fails:** Check Vercel deployment logs

**Resources:**
- [Vercel Documentation](https://vercel.com/docs)
- [GitHub Documentation](https://docs.github.com)
- [Supabase Documentation](https://supabase.com/docs)

---

**You're all set! 🚀 Your project is ready for GitHub and Vercel.**
