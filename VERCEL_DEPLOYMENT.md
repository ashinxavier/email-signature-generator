# Deploying Email Signature Generator to Vercel

This guide will help you deploy your Email Signature Generator to Vercel with Supabase integration.

## Prerequisites

- [Vercel account](https://vercel.com/signup) (free tier is sufficient)
- Vercel CLI installed (optional, for command-line deployment)
- Your Supabase project set up (you already have this)

## Deployment Options

You have two options for deploying to Vercel:

### Option 1: Deploy via Vercel Dashboard (Recommended)

This is the easiest method for first-time deployments.

#### Steps:

1. **Push your code to GitHub** (if not already done)
   - Go to [GitHub](https://github.com) and create a new repository
   - Initialize git in your project folder and push:
     ```bash
     git init
     git add .
     git commit -m "Initial commit"
     git branch -M main
     git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
     git push -u origin main
     ```

2. **Import to Vercel**
   - Go to [Vercel Dashboard](https://vercel.com/new)
   - Click "Import Project"
   - Select your GitHub repository
   - Vercel will auto-detect it as a static site

3. **Configure Environment Variables**
   
   In the Vercel project settings, add your Supabase credentials as environment variables:
   
   - `VITE_SUPABASE_URL`: Your Supabase project URL
   - `VITE_SUPABASE_ANON_KEY`: Your Supabase anonymous/public key
   
   > **Note**: Since this is a static HTML file, environment variables won't work directly. See the configuration section below.

4. **Deploy**
   - Click "Deploy"
   - Vercel will build and deploy your site
   - You'll get a live URL like `https://your-project.vercel.app`

### Option 2: Deploy via Vercel CLI

For quick deployments from the command line:

#### Steps:

1. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **Login to Vercel**
   ```bash
   vercel login
   ```

3. **Deploy from your project directory**
   ```bash
   cd "c:\Users\ashin\OneDrive\Desktop\GEN EMAIL"
   vercel
   ```

4. **Follow the prompts**
   - Set up and deploy: Y
   - Scope: Select your account
   - Link to existing project: N (first time)
   - Project name: `email-signature-generator` (or your preferred name)
   - Directory: `./`
   - Override settings: N

5. **Production deployment**
   ```bash
   vercel --prod
   ```

## Configuring Supabase for Static Deployment

Since you're using a static HTML file, you need to hardcode your Supabase credentials in the HTML file or create a separate configuration file.

### Option A: Update index.html with Supabase Config

Find the Supabase initialization section in your `index.html` and update it:

```javascript
// Supabase Configuration
const SUPABASE_URL = 'https://your-project.supabase.co';
const SUPABASE_ANON_KEY = 'your-anon-key';

// Initialize Supabase
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
```

> ⚠️ **Security Note**: The anonymous key is safe to expose on the client side. Supabase uses Row Level Security (RLS) to protect your data. Make sure your RLS policies are properly configured!

### Option B: Use a config.js file (Better Practice)

1. Create `config.js`:
   ```javascript
   window.SUPABASE_CONFIG = {
     url: 'https://your-project.supabase.co',
     anonKey: 'your-anon-key'
   };
   ```

2. Add to `.gitignore`:
   ```
   config.js
   ```

3. Create `config.example.js` for reference:
   ```javascript
   window.SUPABASE_CONFIG = {
     url: 'YOUR_SUPABASE_URL',
     anonKey: 'YOUR_SUPABASE_ANON_KEY'
   };
   ```

4. Load it in `index.html` before other scripts:
   ```html
   <script src="config.js"></script>
   ```

5. Add environment variable in Vercel to generate `config.js` during build (requires a build step)

## Adding a Build Step (Optional but Recommended)

To properly handle environment variables, convert your project to use a simple build process:

1. **Create `package.json`**:
   ```json
   {
     "name": "email-signature-generator",
     "version": "1.0.0",
     "scripts": {
       "build": "node scripts/generate-config.js"
     }
   }
   ```

2. **Create `scripts/generate-config.js`**:
   ```javascript
   const fs = require('fs');
   
   const config = `
   window.SUPABASE_CONFIG = {
     url: '${process.env.SUPABASE_URL}',
     anonKey: '${process.env.SUPABASE_ANON_KEY}'
   };
   `;
   
   fs.writeFileSync('config.js', config);
   console.log('✅ Config file generated');
   ```

3. **Update Vercel settings**:
   - Build Command: `npm run build`
   - Output Directory: `./`
   - Install Command: `npm install` (or leave empty if no dependencies)

4. **Add environment variables in Vercel**:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`

## Post-Deployment Checklist

After deploying, make sure to:

- [ ] Update Supabase CORS settings to allow your Vercel domain
- [ ] Test authentication flows
- [ ] Test signature saving/loading
- [ ] Test logo upload to Supabase Storage
- [ ] Configure custom domain (optional)
- [ ] Enable HTTPS (automatic with Vercel)

## Updating Supabase CORS Settings

1. Go to your Supabase Dashboard
2. Navigate to **Settings** → **API**
3. Under **CORS Allowed Origins**, add your Vercel URL:
   ```
   https://your-project.vercel.app
   ```
4. If using a custom domain, add that too

## Custom Domain Setup

1. Go to Vercel Dashboard → Your Project → Settings → Domains
2. Add your custom domain
3. Update DNS records as instructed by Vercel
4. Wait for propagation (usually 24-48 hours)

## Troubleshooting

### CORS Errors
- Make sure your Vercel domain is added to Supabase CORS settings
- Check browser console for specific error messages

### Authentication Not Working
- Verify Supabase credentials are correctly set
- Check that redirect URLs in Supabase match your Vercel domain
- Add your production URL to Supabase Authentication → URL Configuration → Site URL

### Logo Upload Fails
- Ensure Supabase Storage bucket policies are correctly configured
- Check that the bucket is public or has appropriate RLS policies

## Continuous Deployment

Once connected to GitHub:
- Every push to `main` branch will automatically deploy to production
- Pull requests will create preview deployments
- You can configure branch deployments in Vercel settings

## Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Vercel Environment Variables](https://vercel.com/docs/concepts/projects/environment-variables)

---

**Need help?** Check the Vercel deployment logs in the dashboard for detailed error messages.
