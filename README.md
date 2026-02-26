# Senior Product Manager Portfolio

A modern, performant portfolio website built with 11ty, Tailwind CSS v4, and optimized for Vercel deployment.

## Tech Stack

- **Static Site Generator**: Eleventy (11ty) v3.1.2
- **CSS Framework**: Tailwind CSS v4
- **Template Engine**: Nunjucks
- **Build Tool**: PostCSS
- **Hosting**: Vercel (recommended)

## Features

- ✅ Fully responsive design
- ✅ SEO optimized with meta tags, canonical URLs, and JSON-LD structured data
- ✅ Performance optimized with critical CSS inlining, lazy loading, and debounced event handlers
- ✅ Accessible with proper ARIA labels and focus management
- ✅ Smooth scroll navigation
- ✅ Interactive project filtering
- ✅ Contact form with validation
- ✅ Mobile-first design

## Performance Optimizations

- **Critical CSS**: Inlined above-the-fold styles to eliminate render-blocking resources
- **Lazy Loading**: Images load only when entering viewport via Intersection Observer
- **Debounced Events**: Scroll handlers use debouncing to reduce CPU usage
- **Passive Listeners**: Scroll events use passive listeners for smoother scrolling
- **RequestAnimationFrame**: Animations use rAF for optimal frame timing
- **DNS Prefetch & Preconnect**: Early connections to font providers
- **Deferred JavaScript**: Non-critical JS loads after page render

## Project Structure

```
portfolio-site/
├── src/
│   ├── _includes/
│   │   ├── layouts/
│   │   │   └── base.njk          # Main layout with SEO & performance optimizations
│   │   ├── header.njk            # Navigation header
│   │   └── footer.njk            # Site footer
│   ├── css/
│   │   ├── input.css             # Source CSS with Tailwind directives
│   │   └── output.css            # Compiled CSS (generated)
│   ├── js/
│   │   └── main.js               # Interactive features & performance utilities
│   ├── images/                   # Image assets
│   ├── index.njk                 # Homepage with all sections
│   └── other-page.njk            # Additional pages
├── .eleventy.js                  # 11ty configuration
├── package.json                  # Dependencies & scripts
├── postcss.config.js             # PostCSS configuration
├── tailwind.config.js            # Tailwind configuration
└── vercel.json                   # Vercel deployment configuration
```

## Local Development

### Prerequisites

- Node.js 18+ installed
- npm or yarn package manager

### Setup

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start development server with watch mode:
   ```bash
   npm run watch
   ```
   This runs both CSS build watcher and 11ty dev server.

3. Open browser to `http://localhost:8080`

### Build Commands

- **Build CSS only**: `npm run build:css`
- **Watch CSS**: `npm run watch:css`
- **Build site**: `npm run build`
- **Serve production build**: `npm run serve`

## Deployment to Vercel

### One-Click Deploy

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/yourusername/portfolio-site)

### Manual Deployment

1. Push your code to GitHub/GitLab/Bitbucket

2. Import project in Vercel:
   - Go to [vercel.com](https://vercel.com)
   - Click "New Project"
   - Import your repository
   - Vercel will auto-detect the settings from `vercel.json`

3. Configure environment variables (none required for this project)

4. Click "Deploy"

### Custom Domain

1. In Vercel dashboard, go to your project settings
2. Navigate to "Domains"
3. Add your custom domain
4. Update DNS records as instructed by Vercel

## Customization Guide

### Update Personal Information

1. **Site Title & Meta**: Edit `src/_includes/layouts/base.njk`:
   - Update `title` variable in the `<title>` tag
   - Modify meta description and keywords
   - Change theme colors in `:root` CSS variables

2. **Hero Section**: Edit `src/index.njk` - Section `#hero`
   - Update heading, subheading, and CTA buttons
   - Replace placeholder image paths

3. **About Section**: Edit `src/index.njk` - Section `#about`
   - Update biography and expertise items

4. **Skills**: Edit the `techSkills` and `softSkills` arrays in `src/index.njk`

5. **Case Studies**: Update the `caseStudies` array with your actual projects

6. **Contact Information**: Edit `src/_includes/footer.njk` and contact form in `src/index.njk`

7. **Social Links**: Update JSON-LD in `base.njk` and social icons in `footer.njk`

### Color Scheme

The color palette is defined in `src/css/input.css` under `@theme`:

- `--color-primary-*`: Primary brand color (blues)
- `--color-secondary-*`: Secondary accent (teal/green)
- `--color-accent-*`: Call-to-action accent (coral/orange)

Modify these hex values to match your brand.

### Fonts

The site uses Google Fonts:
- **Inter** (sans-serif) - Body text
- **Playfair Display** (serif) - Headings

To change fonts:
1. Update `--font-family-sans` and `--font-family-serif` in `src/css/input.css`
2. Modify the Google Fonts link in `base.njk`

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## License

ISC

## Credits

Built with modern web best practices and performance in mind.