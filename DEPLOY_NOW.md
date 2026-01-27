# Quick Start: Deploy to Vercel

## Option 1: Deploy via Vercel CLI (Fastest - Command Line)

### Steps:

1. **Login to Vercel**
   ```bash
   vercel login
   ```
   This will open a browser for authentication.

2. **Deploy your project**
   ```bash
   vercel
   ```
   Follow the prompts:
   - Set up and deploy: **Y**
   - Scope: Select your account
   - Link to existing project: **N** (first time)
   - Project name: **email-signature-generator**
   - Directory: **./.**
   - Override settings: **N**

3. **For production deployment**
   ```bash
   vercel --prod
   ```

You'll get a live URL immediately!

---

## Option 2: Deploy via Vercel Web Dashboard (No CLI needed)

### Steps:

1. **Go to Vercel**
   - Visit: https://vercel.com/new
   - Sign up/Login with GitHub, GitLab, or email

2. **Import via Git** (Recommended for continuous deployment)
   
   a. First, push your code to GitHub:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   ```
   - Create a new repository on GitHub
   - Copy the remote URL and run:
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git
   git push -u origin main
   ```
   
   b. In Vercel dashboard:
   - Click "Import Project"
   - Select your GitHub repository
   - Click "Deploy"

3. **Import without Git** (Drag & Drop)
   
   - In Vercel dashboard, drag and drop your project folder
   - Or click "Browse" and select the folder
   - Click "Deploy"

---

## After Deployment

### Update Supabase Configuration

1. **Add your Vercel URL to Supabase**
   - Go to your Supabase Dashboard
   - Settings → API → CORS Allowed Origins
   - Add: `https://your-project.vercel.app`

2. **Update Authentication URLs**
   - Go to Authentication → URL Configuration
   - Set Site URL to: `https://your-project.vercel.app`
   - Add redirect URL: `https://your-project.vercel.app/**`

### Test Your Deployment

- ✅ Visit your live URL
- ✅ Test sign up/sign in
- ✅ Test signature generation
- ✅ Test saving/loading signatures
- ✅ Test logo upload

---

## Troubleshooting

**CORS Error?**
- Make sure you've added your Vercel domain to Supabase CORS settings

**Can't sign in?**
- Check Supabase Authentication → URL Configuration
- Ensure your Vercel URL is added

**Page not loading?**
- Check Vercel deployment logs in the dashboard
- Verify all files were uploaded correctly

---

## Next Steps

- 🌐 **Add a custom domain** (Vercel Settings → Domains)
- 🔄 **Enable auto-deployments** (Connect to GitHub for CI/CD)
- 📊 **Monitor analytics** (Built-in Vercel Analytics)
- 🚀 **Optimize performance** (Vercel Edge Network handles this automatically)

**Your project is now live! 🎉**
