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

Free hosting directly from GitHub.

### Setup

1. In repository, go to Settings → Pages
2. Source: "Deploy from a branch"
3. Branch: `main` (or `gh-pages` if you prefer)
4. Folder: `/ (root)`
5. Save

**Note**: GitHub Pages doesn't run build commands automatically. You must:
- Build locally: `npm run build`
- Commit the `_site` folder to your repository
- Or use GitHub Actions to automate the build

### GitHub Actions Workflow

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run build
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./_site
```

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