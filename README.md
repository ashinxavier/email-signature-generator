# Email Signature Generator

A beautiful, professional email signature generator with user authentication and cloud storage powered by Supabase.

![Email Signature Generator](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)
![License](https://img.shields.io/badge/License-MIT-blue)

## Features

- **Easy-to-use Form** - Create professional email signatures in seconds
- **3 Signature Templates** - Classic, Modern and Compact layouts
- **Accent Colors** - Match your brand with preset swatches or a custom color
- **Copy Signature (rich text)** - Copies rich HTML to your clipboard, ready to paste into your email client
- **Download as HTML** - Export your signature as a standalone .html file
- **Logo Upload** - Add your company logo with crop and resize tools
- **Live Preview** - See your signature in real-time with light/dark mode
- **User Authentication** - Sign up and save your signatures
- **Cloud Storage** - Save unlimited signatures to your account
- **Style Persistence** - Template and accent choices are remembered in your browser, including per saved signature
- **Reduced Motion** - Respects the prefers-reduced-motion accessibility setting
- **Fully Responsive** - Works perfectly on all devices
- **Email Client Instructions** - Step-by-step guides for Gmail, macOS Mail, and iOS Mail

## Quick Start

1. **Visit the app**: [Live Demo](https://your-app-url.vercel.app)
2. **Fill in your details**: Name, title, company, contact info
3. **Upload logo** (optional): Drag and drop or browse
4. **Pick a style**: Choose a template and accent color
5. **Copy Signature**: Click "Copy Signature" and paste it into your email app (or "Copy HTML" / "Download" for the raw file)
6. **Import to email**: Follow the instructions in the "Import Guide" modal

## Tech Stack

- **Frontend**: Pure HTML, CSS, JavaScript
- **Authentication**: Supabase Auth
- **Database**: Supabase PostgreSQL
- **Storage**: Supabase Storage
- **Hosting**: Vercel

## Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/email-signature-generator.git
   cd email-signature-generator
   ```

2. **Set up Supabase**
   - Follow instructions in `SUPABASE_SETUP.md`
   - Create a Supabase project
   - Run the SQL setup script
   - Get your project URL and anonymous key

3. **Update Supabase credentials**
   - Add your credentials to the `index.html` file (see VERCEL_DEPLOYMENT.md)

4. **Open locally**
   - Simply open `index.html` in your browser
   - Or use a local server: `python -m http.server 8000`

## Deployment

See `DEPLOY_NOW.md` for quick deployment instructions or `VERCEL_DEPLOYMENT.md` for comprehensive guide.

### Deploy to Vercel

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/YOUR_USERNAME/email-signature-generator)

## Testing

- Verified in Chrome with automated UI checks (Playwright): template switching, preset and custom accent colors, form updates, reload persistence, logo upload, HTML download and clipboard payload
- Per-signature style persistence is browser-local (localStorage) and was covered by mocked checks; live save/load requires your Supabase backend
- Not yet tested in live email clients - try your signature in your own email app before rolling it out

## Documentation

- **`SUPABASE_SETUP.md`** - Supabase configuration guide
- **`DEPLOY_NOW.md`** - Quick deployment guide
- **`VERCEL_DEPLOYMENT.md`** - Comprehensive deployment documentation

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

MIT License - feel free to use this for your own projects!

## Acknowledgments

- Built with [Supabase](https://supabase.com)
- Hosted on [Vercel](https://vercel.com)

---

Made with ❤️ for creating beautiful email signatures
