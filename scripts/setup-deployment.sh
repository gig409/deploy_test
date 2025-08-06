#!/bin/bash

# Setup script for Fly.io GitHub Actions deployment
# Run this script to set up staging and production environments

echo "🚀 Setting up Fly.io GitHub Actions deployment..."

# Check if flyctl is installed
if ! command -v flyctl &> /dev/null; then
    echo "❌ flyctl is not installed. Please install it first:"
    echo "   curl -L https://fly.io/install.sh | sh"
    exit 1
fi

# Get the current app name from fly.toml
if [ -f "fly.toml" ]; then
    PROD_APP_NAME=$(grep 'app =' fly.toml | cut -d '"' -f 2)
    echo "📱 Found production app: $PROD_APP_NAME"
else
    echo "❌ fly.toml not found. Please run 'fly launch' first."
    exit 1
fi

# Create staging app name
STAGING_APP_NAME="${PROD_APP_NAME}-staging"
echo "📱 Creating staging app: $STAGING_APP_NAME"

# Clone the production app for staging
echo "🔄 Creating staging environment..."
flyctl apps create $STAGING_APP_NAME --copy-config --from $PROD_APP_NAME

echo ""
echo "✅ Setup complete! Now you need to configure GitHub secrets:"
echo ""
echo "1. Go to your GitHub repository: https://github.com/gig409/deploy_test"
echo "2. Go to Settings > Secrets and variables > Actions"
echo "3. Add these repository secrets:"
echo ""
echo "   FLY_API_TOKEN:"
echo "   - Run: flyctl auth token"
echo "   - Copy the token and add it as FLY_API_TOKEN"
echo ""
echo "   FLY_STAGING_APP_NAME:"
echo "   - Value: $STAGING_APP_NAME"
echo ""
echo "📝 Your apps:"
echo "   Production:  $PROD_APP_NAME (deploys on push to main)"
echo "   Staging:     $STAGING_APP_NAME (deploys on pull requests)"
echo ""
echo "🎉 After setting up the secrets, your deployment workflow will:"
echo "   - Deploy to staging when you create a pull request"
echo "   - Deploy to production when you push to main branch"
