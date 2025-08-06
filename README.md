# Welcome to React Router!

A modern, production-ready template for building full-stack React applications using React Router.

[![Open in StackBlitz](https://developer.stackblitz.com/img/open_in_stackblitz.svg)](https://stackblitz.com/github/remix-run/react-router-templates/tree/main/default)

## Features

- 🚀 Server-side rendering
- ⚡️ Hot Module Replacement (HMR)
- 📦 Asset bundling and optimization
- 🔄 Data loading and mutations
- 🔒 TypeScript by default
- 🎉 TailwindCSS for styling
- 📖 [React Router docs](https://reactrouter.com/)

## Getting Started

### Installation

Install the dependencies:

```bash
npm install
```

### Development

Start the development server with HMR:

```bash
npm run dev
```

Your application will be available at `http://localhost:5173`.

## Building for Production

Create a production build:

```bash
npm run build
```

## Deployment

### Automatic Deployment with GitHub Actions

This project is configured for automatic deployment to Fly.io using GitHub Actions:

- **Staging**: Deploys automatically when you create a pull request
- **Production**: Deploys automatically when you push to the `main` branch

#### Initial Setup

1. **Run the setup script**:
   ```bash
   ./scripts/setup-deployment.sh
   ```

2. **Configure GitHub Secrets**:
   - Go to your repository on GitHub
   - Navigate to Settings > Secrets and variables > Actions
   - Add the following secrets:
     - `FLY_API_TOKEN`: Get this by running `flyctl auth token`
     - `FLY_STAGING_APP_NAME`: Your staging app name (e.g., `your-app-staging`)

#### Workflow

- **For staging**: Create a pull request to trigger a deployment to staging
- **For production**: Push to `main` branch to trigger a production deployment

### Manual Deployment with Fly.io

Alternatively, you can deploy manually:

```bash
flyctl deploy
```

### Docker Deployment

To build and run using Docker:

```bash
docker build -t my-app .

# Run the container
docker run -p 3000:3000 my-app
```

The containerized application can be deployed to any platform that supports Docker, including:

- AWS ECS
- Google Cloud Run
- Azure Container Apps
- Digital Ocean App Platform
- Fly.io
- Railway

### DIY Deployment

If you're familiar with deploying Node applications, the built-in app server is production-ready.

Make sure to deploy the output of `npm run build`

```
├── package.json
├── package-lock.json (or pnpm-lock.yaml, or bun.lockb)
├── build/
│   ├── client/    # Static assets
│   └── server/    # Server-side code
```

## Styling

This template comes with [Tailwind CSS](https://tailwindcss.com/) already configured for a simple default starting experience. You can use whatever CSS framework you prefer.

---

Built with ❤️ using React Router.
