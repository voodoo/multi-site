# Multi-Site Astro

A monorepo for managing multiple Astro sites with shared layouts, components, and styles via git submodules.

## Structure

```
multi-site-astro/
├── shared/                  # Shared git repo (submodule source)
│   ├── layouts/
│   │   ├── BaseLayout.astro
│   │   └── MarkdownLayout.astro
│   ├── components/
│   │   ├── Header.astro
│   │   ├── Footer.astro
│   │   └── SEO.astro
│   └── styles/
│       └── global.css
├── sites/
│   ├── site-template/       # Template for new sites
│   └── <your-sites>/        # Your actual sites
├── new-site.sh              # Script to create a new site
└── README.md
```

## Creating a New Site

```bash
./new-site.sh my-awesome-site
cd sites/my-awesome-site
npm run dev
```

This will:
1. Copy the template
2. Init a git repo
3. Add `shared/` as a git submodule
4. Install dependencies

## How Sharing Works

Each site gets `shared/` as a **git submodule**. Import shared stuff like:

```astro
---
import BaseLayout from '../../shared/layouts/BaseLayout.astro';
import Header from '../../shared/components/Header.astro';
---
```

## Updating Shared Code

Edit in `shared/`, commit, push. Then in each site:

```bash
cd shared
git pull origin main
cd ..
git add shared
git commit -m "Update shared submodule"
```

## Deploying

Each site in `sites/` is independent — deploy wherever you want (Netlify, Vercel, GitHub Pages, etc). Just point the build to the site's directory.

## Adding Shared Stuff

Drop new components/layouts/styles into `shared/`, commit, and update the submodule in your sites. Everything stays in sync.
