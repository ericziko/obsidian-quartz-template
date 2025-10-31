# GitHub Workflow Documentation: Build and Test

This document explains the GitHub Actions workflow defined in `ci.yaml`, which automates the build and deployment process for your Obsidian Quartz site.

## Overview

The workflow consists of two main jobs:

1. **build-and-test**: Verifies that your Quartz site builds correctly
2. **deploy**: Builds and deploys your site to GitHub Pages

## Trigger Events

The workflow runs automatically when:

- Code is pushed to the `main` branch
- Manually triggered using the "Run workflow" button in the GitHub Actions tab (via `workflow_dispatch`)

## Jobs Explanation

### 1. build-and-test

This job checks if your Quartz site can be successfully built without errors.

**Environment**: Ubuntu latest

**Steps**:

- **Checkout code**: Retrieves your repository code including git history
- **Setup Node**: Installs Node.js version 20
- **Cache dependencies**: Speeds up workflow by caching npm packages
- **Install dependencies**: Runs `npm install` in the `./source` directory
- **Set execute permissions**: Makes the bootstrap CLI script executable
- **Build check**: Runs `quartz build --bundleInfo` to verify build works

### 2. deploy

This job builds your site and deploys it to GitHub Pages. It only runs if the `build-and-test` job passes.

**Environment**: Ubuntu latest with GitHub Pages environment

**Steps**:

- **Checkout code**: Retrieves your repository code
- **Setup Node**: Installs Node.js version 20
- **Build Quartz**:
  - Installs dependencies
  - Builds your site with `quartz build`
- **Copy raw HTML**:
  - Copies any content from the `raw_html` directory to the `public` directory
  - Uses `|| true` to prevent failure if the directory doesn't exist
  - Lists directory contents for debugging
- **Setup GitHub Pages**: Configures the GitHub Pages deployment
- **Upload artifact**:
  - Packages the `./source/public` directory for deployment
  - Sets retention to 1 day (GitHub's default for Pages)
- **Deploy**: Publishes the site to GitHub Pages

## Permissions

The workflow uses specific permission settings:

- The build job needs write permissions to the repository contents
- The deploy job needs permissions for Pages deployment

## Working Directory

Most commands run in the `./source` directory, which is where your Quartz site code is located.

## Tips for Beginners

- **View workflow runs**: Go to the "Actions" tab in your GitHub repository
- **Debug failures**: Click on a failed run to see detailed logs
- **Manual trigger**: Use the "Run workflow" button to manually trigger the workflow
- **Environment URL**: The deployed site URL appears in the workflow summary

## Customization

To modify this workflow:

1. Edit `.github/workflows/ci.yaml`
2. Commit and push your changes
3. The updated workflow will be used for future runs

GitHub Actions uses YAML syntax. The indentation is important and determines the structure of the workflow.
