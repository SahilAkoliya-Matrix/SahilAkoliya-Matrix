#!/bin/bash

# GitHub Quick Achievements Script
# Helps you earn Quickdraw and YOLO achievements safely

echo "🏆 GitHub Quick Achievements Earner"
echo "==================================="
echo ""
echo "This script will help you earn:"
echo "  ⚡ Quickdraw - Close issue/PR within 5 minutes"
echo "  🎲 YOLO - Merge PR without code review"
echo "  👥 Pair Extraordinaire - Co-authored commit"
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not a git repository!"
    echo "Please run this from: /Users/sahilakoliya/Work/Matrix/SahilAkoliya-Matrix/"
    exit 1
fi

# Get current user info
GITHUB_USER=$(gh api user -q '.login')
if [ -z "$GITHUB_USER" ]; then
    echo "❌ Error: GitHub CLI not authenticated!"
    echo "Please run: gh auth login"
    exit 1
fi

echo "✅ Logged in as: $GITHUB_USER"
echo ""

# Achievement 1: Quickdraw
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚡ Achievement 1: Quickdraw"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

read -p "Earn Quickdraw achievement? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📝 Creating test issue..."

    ISSUE_URL=$(gh issue create \
        --title "Test issue for Quickdraw achievement" \
        --body "This issue was created to earn the Quickdraw achievement. It will be closed immediately." \
        2>&1)

    if [ $? -eq 0 ]; then
        # Extract issue number from URL
        ISSUE_NUM=$(echo $ISSUE_URL | grep -o '[0-9]*$')
        echo "✅ Issue #$ISSUE_NUM created: $ISSUE_URL"
        echo ""
        echo "⏱️  Closing issue immediately (for Quickdraw)..."
        sleep 2

        gh issue close $ISSUE_NUM --comment "Closing for Quickdraw achievement."

        if [ $? -eq 0 ]; then
            echo "✅ Issue closed successfully!"
            echo "🏆 Quickdraw achievement should be earned!"
            echo ""
        else
            echo "❌ Failed to close issue"
        fi
    else
        echo "❌ Failed to create issue"
    fi
else
    echo "⏭️  Skipping Quickdraw"
fi

echo ""

# Achievement 2: YOLO
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎲 Achievement 2: YOLO"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

read -p "Earn YOLO achievement? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    BRANCH_NAME="achievement/yolo-$(date +%s)"

    echo "📝 Creating branch: $BRANCH_NAME"
    git checkout -b $BRANCH_NAME

    echo "📝 Making a test change..."
    echo "# Achievement Test" > achievement-test-yolo.md
    echo "" >> achievement-test-yolo.md
    echo "This file was created to earn the YOLO achievement." >> achievement-test-yolo.md
    echo "Created at: $(date)" >> achievement-test-yolo.md

    git add achievement-test-yolo.md
    git commit -m "test: Add file for YOLO achievement"

    echo "📤 Pushing branch to GitHub..."
    git push origin $BRANCH_NAME

    echo ""
    echo "✅ Branch pushed!"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎯 NOW DO THIS MANUALLY (WITHIN 5 MINUTES!):"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "1. Go to: https://github.com/$GITHUB_USER/SahilAkoliya-Matrix"
    echo ""
    echo "2. You'll see: \"$BRANCH_NAME had recent pushes\""
    echo "   Click: 'Compare & pull request'"
    echo ""
    echo "3. Click: 'Create pull request'"
    echo ""
    echo "4. IMMEDIATELY Click: 'Merge pull request'"
    echo "   (Don't wait for review - this earns YOLO! 🎲)"
    echo ""
    echo "5. Click: 'Confirm merge'"
    echo ""
    echo "6. Press Enter here when done..."
    echo ""
    read -p "Press Enter after merging the PR..."

    echo ""
    echo "🧹 Cleaning up..."
    git checkout main
    git pull origin main
    git branch -D $BRANCH_NAME

    if [ -f "achievement-test-yolo.md" ]; then
        rm achievement-test-yolo.md
        git add -A
        git commit -m "clean: Remove achievement test file"
        git push origin main
    fi

    echo "✅ Cleanup complete!"
    echo "🏆 YOLO achievement should be earned!"
else
    echo "⏭️  Skipping YOLO"
fi

echo ""

# Achievement 3: Pair Extraordinaire
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "👥 Achievement 3: Pair Extraordinaire"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

read -p "Earn Pair Extraordinaire achievement? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📝 Creating co-authored commit..."

    echo "# Team Collaboration" > team-collab.md
    echo "" >> team-collab.md
    echo "This file demonstrates team collaboration." >> team-collab.md
    echo "Created at: $(date)" >> team-collab.md

    git add team-collab.md
    git commit -m "docs: Add team collaboration file

Co-authored-by: Team Member <team@example.com>"

    echo "📤 Pushing to GitHub..."
    git push origin main

    echo "✅ Co-authored commit created!"
    echo "🏆 Pair Extraordinaire achievement should be earned!"
else
    echo "⏭️  Skipping Pair Extraordinaire"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Script Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🏆 Achievements you may have earned:"
echo "  ⚡ Quickdraw"
echo "  🎲 YOLO"
echo "  👥 Pair Extraordinaire"
echo ""
echo "⏱️  Note: Achievements can take 5-15 minutes to appear"
echo ""
echo "📊 Check your achievements at:"
echo "  https://github.com/$GITHUB_USER?tab=achievements"
echo ""
echo "💡 Don't forget to enable achievements in your settings:"
echo "  https://github.com/settings/profile"
echo "  ✅ Check: 'Show Achievements on my profile'"
echo ""
echo "🎉 Happy achieving!"
echo ""
