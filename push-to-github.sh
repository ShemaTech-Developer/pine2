#!/usr/bin/env bash
# PineNotes — Push to GitHub (Vercel will auto-redeploy)
# How to use:
#   1. On github.com create an EMPTY repo called: PineNotes (Public, no README)
#   2. Edit REPO_URL below with YOUR github username
#   3. In Terminal:  cd /home/shema-lucky/pine && chmod +x push-to-github.sh && ./push-to-github.sh
#   When GitHub asks for a password, paste a Personal Access Token (not your normal password).
set -e

REPO_URL="https://github.com/YOUR-USERNAME/PineNotes.git"
BRANCH="main"
MSG="PineNotes update: shared Supabase library, 50MB uploads, Pine AI, pine-tree PWA icon"

cd "$(dirname "$0")"
echo "📂 Folder: $(pwd)"
ls -1

if [ ! -d .git ]; then
  echo "🔧 Initializing git..."
  git init -b "$BRANCH"
fi

git config user.name "PineNotes" || true
git config user.email "shemalucky83@gmail.com" || true

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REPO_URL"
else
  git remote add origin "$REPO_URL"
fi

echo "📦 Adding files..."
git add -A

echo "✍️ Committing..."
git commit -m "$MSG" || echo "Nothing new to commit (already up to date)."

echo "🚀 Pushing to GitHub: $REPO_URL"
git push -u origin "$BRANCH"

echo ""
echo "✅ Done! Now go to vercel.com -> your project -> Deployments"
echo "   Vercel should show a new deployment 'Building...' -> 'Ready' in 1-2 min."
echo "   Then open your site and press Ctrl+Shift+R"
