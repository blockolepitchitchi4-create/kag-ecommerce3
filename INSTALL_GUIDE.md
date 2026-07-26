# 📖 Installation & Setup Guide

## Prerequisites

Before installing, make sure you have:

- **Node.js 18+** ([Download](https://nodejs.org))
- **npm** (comes with Node.js)
- **Cloudflare Account** (free: [cloudflare.com](https://cloudflare.com))
- **Wrangler CLI** (will install)

---

## Quick Start (5 Minutes)

### 1. Extract the ZIP
```bash
unzip kag-ecommerce-template.zip
cd kag-ecommerce3
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Run Locally
```bash
npm run dev
```

Open http://localhost:5173 in your browser ✓

---

## Local Development

### Run Development Server
```bash
npm run dev
```

- Frontend: http://localhost:5173
- Hot reload enabled (saves = auto-refresh)
- TypeScript checking enabled

### Explore the Code

```
src/
├── App.tsx                 # Main React component
├── components/             # UI components
├── hooks/                  # Custom React hooks
├── types.ts                # TypeScript definitions
└── index.css               # Tailwind CSS

worker/
├── index.ts                # Worker fetch handler
├── workflow.ts             # Workflow logic
└── durable-object.ts       # WebSocket state manager
```

---

## Customization Guide

### Changing Workflow Steps

Edit `worker/workflow.ts`:

```typescript
// Add your custom step
await notifyStep("my-custom-step", "running");
const result = await step.do("my-custom-step", async () => {
  // Your logic here
  return { data: "result" };
});
await notifyStep("my-custom-step", "completed");
```

### Customizing UI

Edit `src/App.tsx`:

```typescript
// Change header title
<h1>My E-commerce Platform</h1>

// Add custom buttons
<button onClick={handleCustomAction}>My Action</button>
```

### Adding Authentication

Recommended: Use **Clerk** or **Auth0**

```bash
npm install @clerk/clerk-react
```

Then wrap your app with Clerk provider.

### Integrating Payment Provider

For **Stripe**:

```bash
npm install @stripe/react-stripe-js @stripe/stripe-js
```

### Connecting Database

The template uses **Durable Objects** for state. To add a database:

1. **SQLite (built-in):** Use Durable Objects storage
2. **PostgreSQL:** Add via environment variables
3. **MongoDB:** Use Cloudflare integration

---

## Deploying to Production

### Option 1: Cloudflare Workers (Recommended)

```bash
# Install Wrangler if not already
npm install -g wrangler

# Login to Cloudflare
wrangler login

# Deploy
npm run deploy
```

Your app will be live at: `https://your-project.workers.dev`

### Option 2: Vercel

```bash
npm run build

# Install Vercel CLI
npm install -g vercel

# Deploy
vercel deploy --prod
```

### Option 3: Netlify

```bash
npm run build

# Deploy the dist/ folder to Netlify
```

---

## Environment Configuration

### Create `.env.local` for local development

```env
# Cloudflare Account ID
VITE_CLOUDFLARE_ACCOUNT_ID=your_account_id

# Worker name (optional)
VITE_WORKER_NAME=kag-ecommerce3

# API endpoints
VITE_API_BASE=http://localhost:8787
VITE_WS_BASE=ws://localhost:8787
```

### For Production

Update `wrangler.jsonc`:

```json
{
  "name": "your-project-name",
  "compatibility_date": "2025-10-08",
  "account_id": "your_account_id",
  "env": {
    "production": {
      "routes": [
        {
          "pattern": "yourdomain.com/*",
          "zone_name": "yourdomain.com"
        }
      ]
    }
  }
}
```

---

## Building for Production

### Build the project
```bash
npm run build
```

This creates:
- `dist/` - Frontend built files
- Worker compiled at `.wrangler/`

### Optimize for Performance

The template already includes optimizations:
- ✓ TypeScript compilation
- ✓ Tree-shaking unused code
- ✓ CSS minification (Tailwind)
- ✓ Code splitting

### Check bundle size
```bash
npm run build
# Check dist/ folder size
ls -lh dist/
```

---

## Troubleshooting

### Issue: "npm install" fails

**Solution:**
```bash
# Clear cache
npm cache clean --force

# Delete node_modules
rm -rf node_modules package-lock.json

# Reinstall
npm install
```

### Issue: Port 5173 already in use

**Solution:**
```bash
# Kill the process on port 5173
# macOS/Linux:
lsof -ti:5173 | xargs kill -9

# Windows:
netstat -ano | findstr :5173
taskkill /PID <PID> /F
```

### Issue: WebSocket connection fails

**Possible causes:**
1. Worker not running (`npm run dev`)
2. Browser privacy settings blocking WebSocket
3. Wrong WebSocket URL in code

**Solution:**
```bash
# Make sure both are running:
npm run dev              # Frontend + Worker
# Check browser console for errors (F12)
```

### Issue: TypeScript errors

**Solution:**
```bash
# Check TypeScript
npm run check

# Fix issues
npm run lint -- --fix

# Generate Cloudflare types
npm run cf-typegen
```

### Issue: "Failed to deploy"

**Solution:**
```bash
# Verify you're logged in
wrangler whoami

# Try logging in again
wrangler login

# Check wrangler.jsonc is correct
# Then retry
npm run deploy
```

---

## Development Commands

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Check code quality
npm run check

# Run linter
npm run lint

# Fix linting issues
npm run lint -- --fix

# Run tests
npm run test

# Deploy to Cloudflare
npm run deploy

# Preview production build
npm run preview

# Generate Cloudflare type definitions
npm run cf-typegen
```

---

## Performance Tips

### For Local Development
- Run `npm run dev` instead of `npm run build && npm run preview`
- Use browser DevTools (F12) to check performance
- Check Chrome Network tab for slow requests

### For Production
- Enable Cloudflare caching on your domain
- Use images in WebP format
- Minimize workflow steps (faster = better)
- Test on slow networks (DevTools throttling)

---

## Security Best Practices

### Before Deploying to Production

- [ ] Remove all `console.log()` statements
- [ ] Use environment variables for secrets (API keys)
- [ ] Validate all user inputs
- [ ] Use HTTPS only
- [ ] Set CORS headers properly
- [ ] Implement rate limiting
- [ ] Add authentication to sensitive endpoints

### Example: Add API Key Protection

```typescript
// In worker/index.ts
const API_KEY = env.API_KEY;

if (request.headers.get("Authorization") !== `Bearer ${API_KEY}`) {
  return new Response("Unauthorized", { status: 401 });
}
```

---

## Getting Help

### Resources

- **Cloudflare Workflows Docs:** https://developers.cloudflare.com/workflows
- **Cloudflare Workers Docs:** https://developers.cloudflare.com/workers
- **React Docs:** https://react.dev
- **TypeScript Docs:** https://www.typescriptlang.org

### Support

- Email: included with purchase
- GitHub Issues: https://github.com/blockolepitchitchi4-create/kag-ecommerce3
- Discord: Join Cloudflare Discord community

---

## Next Steps

1. **Customize** the workflow for your use case
2. **Add authentication** (Clerk/Auth0)
3. **Integrate payments** (Stripe/Paddle)
4. **Connect database** (if needed)
5. **Deploy to production** (Cloudflare Workers)
6. **Monitor** performance (check Cloudflare dashboard)

---

## Congratulations! 🎉

You now have a production-ready e-commerce platform running on Cloudflare!

Next: Customize it for your needs and launch!
