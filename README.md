# Entertainment Tadka Telegram Bot

A Telegram bot for managing and sharing movies across multiple channels.

## Features
- 🤖 Multi-channel movie management
- 🔍 Smart movie search with fuzzy matching
- 📁 CSV-based movie database
- 📊 User statistics and leaderboard
- 🔄 Automatic backups to Telegram channel
- 🎯 Multi-language support (Hindi/English/Hinglish)

## Setup on Render.com

### 1. Prerequisites
- Telegram Bot Token from @BotFather
- Admin User ID
- Render.com account

### 2. Deployment Steps

#### Step 1: Fork/Create Repository
Create a new Git repository with all the configuration files.

#### Step 2: Render.com Setup
1. Go to [Render.com](https://render.com)
2. Click "New +" → "Web Service"
3. Connect your GitHub/GitLab repository
4. Configure service:
   - **Name**: `telegram-bot`
   - **Environment**: `Docker`
   - **Plan**: `Free`
   - **Dockerfile Path**: `./Dockerfile`
   - **Port**: `8080`

#### Step 3: Environment Variables
Add these environment variables in Render.com dashboard:
- `BOT_TOKEN` = Your Telegram bot token
- `ADMIN_ID` = Your Telegram user ID
- `PORT` = `8080`

#### Step 4: Deploy
Click "Create Web Service" and wait for deployment.

#### Step 5: Set Webhook
Once deployed, set the webhook: