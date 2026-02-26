# Deployment Guide

This guide covers deploying your portfolio site to various hosting platforms.

## Recommended: Vercel

Vercel is the optimal choice for 11ty projects with zero configuration needed.

### Prerequisites

- GitHub/GitLab/Bitbucket repository with your code
- Vercel account (free tier available)

### Deployment Steps

1. **Push to Git**
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

2. **Import Project**
   - Log into [Vercel](https://vercel.com)
   - Click "New Project"
   - Import your repository
   - Vercel auto-detects settings from `vercel.json`

3. **Configure**
   - Framework Preset: `Other`
   - Build Command: `npm run build`
   - Output Directory: `_site`
   - No environment variables needed

4. **Deploy**
   - Click "Deploy"
   - Wait 1-2 minutes for build to complete
   - Your site will be live at `your-project.vercel.app`

### Custom Domain Setup

1. In Vercel Dashboard → Your Project → Settings → Domains
2. Add your domain (e.g., `yourname.com`)
3. Vercel provides DNS records to configure:
   - Add A records pointing to Vercel's IPs
   - Or add CNAME for subdomains
4. Wait for DNS propagation (up to 48 hours)

### Automatic Deployments

- **Production**: Pushes to `main` branch auto-deploy
- **Preview**: Pull requests create preview deployments
- **Development**: `vercel dev` for local testing

## Alternative: Netlify

Netlify also works well with 11ty.

### Steps

1. Push code to Git repository
2. Log into [Netlify](https://netlify.com)
3. Click "New site from Git"
4. Choose repository and branch
5. Build settings:
   - Build command: `npm run build`
   - Publish directory: `_site`
6. Click "Deploy site"

### Domain Configuration

Similar to Vercel - add domain in Site settings → Domain management.

## Alternative: GitHub Pages

Free hosting directly from GitHub with automated builds via GitHub Actions.

### Automated Deployment (Recommended)

The project includes a pre-configured GitHub Actions workflow (`.github/workflows/deploy.yml`) that automatically builds and deploys on every push to `main`.

#### Setup Steps:

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/yourusername/your-repo.git
   git push -u origin main
   ```

2. **Enable GitHub Pages**
   - Go to your repository → Settings → Pages
   - Source: "GitHub Actions"
   - The workflow will automatically deploy to GitHub Pages

3. **Access Your Site**
   - After the first workflow completes, your site will be at:
     `https://yourusername.github.io/your-repo/`

4. **Custom Domain (Optional)**
   - In repository Settings → Pages → Custom domain
   - Add your domain (e.g., `yourname.com`)
   - GitHub will automatically configure SSL

#### Manual Deployment

If you prefer manual control, use the provided script:

```bash
npm run deploy
```

This script:
- Builds the site
- Creates/updates the `gh-pages` branch
- Pushes the built files to GitHub Pages

#### Important Notes for GitHub Pages

- **Relative Paths**: Asset paths are configured as relative (`css/output.css`, `js/main.js`) to work from the subdirectory
- **No Jekyll**: The `.nojekyll` file disables Jekyll processing (GitHub's default static site processor)
- **Build Time**: First deploy may take 2-3 minutes while GitHub provisions the Pages service

### GitHub Actions Workflow Details

The workflow (`.github/workflows/deploy.yml`):

- **Trigger**: Push to `main` or `master` branches
- **Build Steps**:
  1. Checkout code
  2. Setup Node.js 18
  3. Install dependencies (`npm ci`)
  4. Build CSS (`npm run build:css`)
  5. Build site (`npm run build`)
  6. Deploy to `gh-pages` branch using `peaceiris/actions-gh-pages`

- **Configuration**: Edit `cname` in the workflow if using a custom domain

## Performance Checklist Before Deploy

- [ ] Run production build: `npm run build`
- [ ] Test locally: `npm run serve` and verify all pages work
- [ ] Check Lighthouse scores (Chrome DevTools)
- [ ] Verify all images are optimized (use WebP format if possible)
- [ ] Test on mobile devices
- [ ] Verify all links work correctly
- [ ] Check meta tags and Open Graph images
- [ ] Test contact form (if using backend, ensure API endpoints work)
- [ ] Set up analytics (Google Analytics, Plausible, etc.)

## Environment Variables

If you add a contact form backend or analytics, configure environment variables:

### Vercel
- Project Settings → Environment Variables
- Add `NEXT_PUBLIC_` prefix for client-side access

### Netlify
- Site Settings → Build & Deploy → Environment
- Add variables with `NEXT_PUBLIC_` prefix

## Continuous Integration

### Vercel
- Automatic on every push
- Preview deployments for PRs
- No additional configuration needed

### Netlify
- Automatic on every push
- Branch deploys and PR previews available

## Rollback

### Vercel
- Dashboard → Deployments
- Click "Promote" on previous deployment

### Netlify
- Deploys → Select previous deploy → "Publish deploy"

## Monitoring

- **Vercel Analytics**: Built-in in dashboard
- **Google Analytics**: Add GA script to `base.njk`
- **Error Tracking**: Consider Sentry or LogRocket

## SSL Certificates

All platforms provide free automatic SSL:
- Vercel: Automatic via Let's Encrypt
- Netlify: Automatic via Let's Encrypt
- GitHub Pages: Automatic via Cloudflare

## Troubleshooting

### Build Fails on Vercel
- Check build logs in Vercel dashboard
- Ensure `package.json` scripts are correct
- Verify Node.js version (set in `engines` field if needed)

### CSS Not Loading
- Verify `output.css` is generated in `_site/css/`
- Check that `base.njk` references `/css/output.css`
- Ensure PostCSS build runs before 11ty

### 404 on Subpages
- Check `permalink` settings in 11ty templates
- Verify `cleanUrls` in `vercel.json` (set to `true` for clean URLs)

### Images Not Showing
- Ensure images are in `src/images/` and passthroughCopy is configured
- Check image paths in templates (should be `/images/your-image.jpg`)
- Verify images are copied to `_site/images/`

## Support

For platform-specific issues:
- Vercel: [vercel.com/docs](https://vercel.com/docs)
- Netlify: [docs.netlify.com](https://docs.netlify.com)
- GitHub Pages: [docs.github.com/pages](https://docs.github.com/pages)