#!/bin/bash
# Pre-Implementation Hook - Ensures existing tests pass before new features

echo "🔍 Running pre-implementation checks..."

# Check if we're in a .NET project
if [ -f *.sln ] || [ -f *.csproj ]; then
    echo "📋 Running existing unit tests..."
    
    # Run only unit tests (not integration)
    dotnet test --filter "Category!=Integration" --no-build 2>/dev/null
    
    if [ $? -ne 0 ]; then
        echo "❌ ERROR: Existing tests must pass before implementing new features!"
        echo "🔧 Fix failing tests first, then try again."
        exit 1
    fi
    
    echo "✅ All existing tests pass!"
else
    echo "⚠️  No .NET solution found. Skipping test check."
fi

# Check for uncommitted changes
if git diff --quiet && git diff --cached --quiet; then
    echo "✅ Working directory clean"
else
    echo "⚠️  Warning: You have uncommitted changes"
    echo "💡 Consider committing or stashing before major changes"
fi

echo "✅ Pre-implementation checks complete. Ready to proceed!"
exit 0