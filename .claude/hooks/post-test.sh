#!/bin/bash
# Post-Test Hook - Updates artifacts with test results

echo "📊 Updating test artifacts..."

ARTIFACT_DIR=".claude/artifacts"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Ensure artifact directory exists
mkdir -p "$ARTIFACT_DIR/test-results"

# Function to extract test results
extract_test_results() {
    if [ -f *.sln ] || [ -f *.csproj ]; then
        echo "📈 Capturing test results..."
        
        # Run tests with detailed output
        TEST_OUTPUT=$(dotnet test --logger "console;verbosity=normal" 2>&1)
        
        # Extract summary
        TOTAL=$(echo "$TEST_OUTPUT" | grep -oP 'Total:?\s*\K\d+' | head -1)
        PASSED=$(echo "$TEST_OUTPUT" | grep -oP 'Passed:?\s*\K\d+' | head -1)
        FAILED=$(echo "$TEST_OUTPUT" | grep -oP 'Failed:?\s*\K\d+' | head -1)
        SKIPPED=$(echo "$TEST_OUTPUT" | grep -oP 'Skipped:?\s*\K\d+' | head -1)
        
        # Default to 0 if not found
        TOTAL=${TOTAL:-0}
        PASSED=${PASSED:-0}
        FAILED=${FAILED:-0}
        SKIPPED=${SKIPPED:-0}
        
        # Create JSON result
        cat > "$ARTIFACT_DIR/test-results/latest.json" <<EOF
{
    "timestamp": "$TIMESTAMP",
    "summary": {
        "total": $TOTAL,
        "passed": $PASSED,
        "failed": $FAILED,
        "skipped": $SKIPPED
    },
    "success": $([ $FAILED -eq 0 ] && echo "true" || echo "false")
}
EOF
        
        # Save full output
        echo "$TEST_OUTPUT" > "$ARTIFACT_DIR/test-results/latest-output.txt"
        
        # Update history
        cp "$ARTIFACT_DIR/test-results/latest.json" "$ARTIFACT_DIR/test-results/history-$TIMESTAMP.json"
        
        echo "✅ Test results saved to artifacts"
        
        # Show summary
        echo "📊 Test Summary:"
        echo "   Total: $TOTAL"
        echo "   ✅ Passed: $PASSED"
        echo "   ❌ Failed: $FAILED"
        echo "   ⏭️  Skipped: $SKIPPED"
        
        if [ $FAILED -gt 0 ]; then
            echo "⚠️  Warning: $FAILED test(s) failed!"
            return 1
        fi
    else
        echo "⚠️  No .NET project found"
    fi
    
    return 0
}

# Execute test result extraction
extract_test_results
TEST_RESULT=$?

# Update checkpoint if tests pass
if [ $TEST_RESULT -eq 0 ]; then
    echo "💾 Creating checkpoint..."
    
    # Get current git commit (if in git repo)
    if git rev-parse --git-dir > /dev/null 2>&1; then
        COMMIT=$(git rev-parse HEAD 2>/dev/null || echo "no-commit")
        BRANCH=$(git branch --show-current 2>/dev/null || echo "no-branch")
    else
        COMMIT="no-git"
        BRANCH="no-git"
    fi
    
    # Create checkpoint
    cat > "$ARTIFACT_DIR/checkpoint.json" <<EOF
{
    "timestamp": "$TIMESTAMP",
    "commit": "$COMMIT",
    "branch": "$BRANCH",
    "tests": {
        "total": ${TOTAL:-0},
        "passing": ${PASSED:-0},
        "failing": ${FAILED:-0}
    },
    "functionalState": "working",
    "lastVerified": "$TIMESTAMP"
}
EOF
    
    echo "✅ Checkpoint created"
fi

echo "✅ Artifact update complete"
exit $TEST_RESULT