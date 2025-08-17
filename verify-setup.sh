#!/bin/bash
# Verification script to ensure the Autonomous TDD Solution Architecture System is properly set up

echo "🔍 Verifying Autonomous TDD Solution Architecture System..."
echo "=================================================="

# Check for required files
echo "📁 Checking required files..."

FILES=(
    "MASTER_PROMPT_V2.md"
    "CLAUDE.md"
    "QUICK_START.md"
    "README.md"
    "TDD_WORKFLOW.md"
    ".claude/agents/solution-architect.md"
    ".claude/agents/red-agent.md"
    ".claude/agents/green-agent.md"
    ".claude/hooks/autonomous-tdd.sh"
    ".claude/hooks/pre-implementation.sh"
    ".claude/hooks/verify-build.sh"
    ".claude/hooks/post-test.sh"
    ".claude/artifacts/current-state.json"
    ".claude/mcp-tools/solution-selector.json"
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
    ".claude/hooks/autonomous-tdd.sh"
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
    ".claude/agents"
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
    echo "1. Start Claude with: 'Load MASTER_PROMPT_V2.md and CLAUDE.md'"
    echo "2. Present your requirement to get 3 solution options"
    echo "3. Select option 1, 2, or 3"
    echo "4. Watch autonomous TDD implementation via Sonnet sub-agents"
else
    echo "❌ Setup incomplete. Please fix the issues above."
    exit 1
fi

echo ""
echo "📚 Quick Reference:"
echo "  - System prompt: MASTER_PROMPT_V2.md"
echo "  - Project configuration: CLAUDE.md"
echo "  - Usage examples: QUICK_START.md"
echo "  - Agent definitions: .claude/agents/"
echo "  - Automation hooks: .claude/hooks/"
echo "  - Progress tracking: .claude/artifacts/"
echo ""
echo "🎯 Key Features:"
echo "  - Always get exactly 3 solution options"
echo "  - Autonomous TDD through specialized agents"
echo "  - Continuous functional code between interactions"
echo ""
echo "Happy solutioning with Claude! 🤖"