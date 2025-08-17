#!/bin/bash
# Verification script to ensure the system is properly set up

echo "🔍 Verifying Claude Full-Stack Development System Setup..."
echo "=================================================="

# Check for required files
echo "📁 Checking required files..."

FILES=(
    "MASTER_PROMPT.md"
    "CLAUDE.md"
    "TDD_WORKFLOW.md"
    "README.md"
    ".claude/hooks/pre-implementation.sh"
    ".claude/hooks/verify-build.sh"
    ".claude/hooks/post-test.sh"
    ".claude/artifacts/current-state.json"
    ".claude/mcp-tools/test-runner.json"
)

ALL_GOOD=true

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file (missing)"
        ALL_GOOD=false
    fi
done

# Check if hooks are executable
echo ""
echo "🔧 Checking hook permissions..."

HOOKS=(
    ".claude/hooks/pre-implementation.sh"
    ".claude/hooks/verify-build.sh"
    ".claude/hooks/post-test.sh"
)

for hook in "${HOOKS[@]}"; do
    if [ -x "$hook" ]; then
        echo "  ✅ $hook is executable"
    else
        echo "  ❌ $hook is not executable"
        echo "     Run: chmod +x $hook"
        ALL_GOOD=false
    fi
done

# Check directory structure
echo ""
echo "📂 Checking directory structure..."

DIRS=(
    ".claude"
    ".claude/hooks"
    ".claude/artifacts"
    ".claude/artifacts/test-results"
    ".claude/mcp-tools"
)

for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "  ✅ $dir/"
    else
        echo "  ❌ $dir/ (missing)"
        ALL_GOOD=false
    fi
done

# Final status
echo ""
echo "=================================================="

if [ "$ALL_GOOD" = true ]; then
    echo "✅ System setup verified successfully!"
    echo ""
    echo "🚀 Next steps:"
    echo "1. Start Claude with: 'Load MASTER_PROMPT.md and CLAUDE.md'"
    echo "2. Begin with: 'Create initial project structure with failing test'"
    echo "3. Follow verification points in the workflow"
else
    echo "❌ Setup incomplete. Please fix the issues above."
    exit 1
fi

echo ""
echo "📚 Quick Reference:"
echo "  - Development methodology: MASTER_PROMPT.md"
echo "  - Project configuration: CLAUDE.md"
echo "  - Testing guidelines: TDD_WORKFLOW.md"
echo "  - Hook scripts: .claude/hooks/"
echo "  - Progress tracking: .claude/artifacts/"
echo ""
echo "Happy coding with Claude! 🤖"