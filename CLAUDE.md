# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project: Autonomous TDD Solution Architecture System

This repository implements a collaborative solution design system with autonomous Test-Driven Development execution through specialized sub-agents.

## Core Workflow

1. **Present 3 Solutions**: For every requirement, present exactly 3 architectural options
2. **User Selection**: Wait for user to select option 1, 2, or 3
3. **Autonomous TDD**: Execute Red→Green→Refactor cycle via Sonnet sub-agents
4. **Maintain Functional State**: Ensure all tests pass between interactions

## Common Commands

### Testing
```bash
# Run all tests
dotnet test

# Run specific test category
dotnet test --filter "Category=Unit"
dotnet test --filter "Category=Integration"
dotnet test --filter "Category=E2E"

# Run with coverage
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

# Run single test
dotnet test --filter "FullyQualifiedName~TestClassName.TestMethodName"

# Verbose test output
dotnet test --logger "console;verbosity=detailed"
```

### Building
```bash
# Build solution
dotnet build

# Build for specific platform (MAUI)
dotnet build -f net8.0-android
dotnet build -f net8.0-windows10.0.19041.0

# Release build
dotnet build -c Release

# Publish Android APK
dotnet publish -f net8.0-android -c Release
```

### Development
```bash
# Watch mode for auto-rebuild
dotnet watch run -f net8.0-windows10.0.19041.0

# Create new projects
dotnet new sln -n ProjectName
dotnet new maui -n ProjectName.MAUI
dotnet new classlib -n ProjectName.Core
dotnet new webapi -n ProjectName.API
dotnet new nunit -n ProjectName.Tests

# Add project references
dotnet add ProjectName.Tests reference ProjectName.Core
dotnet sln add ProjectName.Core/ProjectName.Core.csproj
```

### Automation Hooks
```bash
# Run autonomous TDD cycle
./.claude/hooks/autonomous-tdd.sh

# Pre-implementation checks
./.claude/hooks/pre-implementation.sh

# Verify build status
./.claude/hooks/verify-build.sh

# Update test artifacts
./.claude/hooks/post-test.sh
```

## Architecture

### Solution Selection System
The system uses a three-option decision framework where every technical decision is presented as exactly 3 choices:
- **Option 1**: Conservative/Simple approach
- **Option 2**: Balanced/Recommended approach
- **Option 3**: Advanced/Complex approach

Implementation happens through specialized sub-agents defined in `.claude/agents/`:
- **solution-architect.md**: Presents 3 solutions for requirements
- **red-agent.md**: Creates comprehensive failing tests
- **green-agent.md**: Implements minimal code to pass tests
- **refactor-agent.md**: Improves code quality while maintaining tests

### TDD Automation Flow
```
User Requirement 
  → Solution Architect (3 options)
  → User Selection
  → Red Agent (Sonnet): Create failing tests
  → Green Agent (Sonnet): Minimal implementation
  → Refactor Agent (Sonnet): Code improvement
  → Integration Agent (Sonnet): System verification
  → User Review
```

### Project Structure Pattern
For full-stack applications:
```
ProjectName/
├── ProjectName.Core/        # Business logic (testable, no UI)
├── ProjectName.API/         # Backend services
├── ProjectName.MAUI/        # Mobile/Desktop UI
├── ProjectName.Web/         # Web frontend (if applicable)
└── ProjectName.Tests/       # All test projects
    ├── Unit/
    ├── Integration/
    └── E2E/
```

### MCP Tool Configuration
The `.claude/mcp-tools/` directory contains tool orchestration:
- **solution-selector.json**: Manages sub-agent delegation for TDD phases
- **test-runner.json**: Automated test execution with category filtering

## Current Context

### AudioStreamer MAUI Application
Target: Real-time audio streaming to OpenAI Whisper
- **Platform Priority**: Android primary, Windows for testing
- **Architecture Decision**: WebSocket streaming with chunked audio
- **Test Framework**: NUnit with Moq for mocking
- **Coverage Target**: Minimum 80% for unit tests

### Next Implementation Steps
1. Create initial solution structure
2. Implement audio capture service with tests
3. Add WebSocket streaming layer
4. Integrate Whisper Python wrapper
5. Build MAUI UI with live transcription display

## Key Principles

When implementing features:
1. Always start with failing tests (Red phase)
2. Write minimal code to pass (Green phase)
3. Refactor only with passing tests (Refactor phase)
4. Delegate test creation and implementation to Sonnet sub-agents
5. Maintain checkpoint artifacts in `.claude/artifacts/`
6. Never proceed with failing tests
7. Present 3 solutions for architectural decisions

## Sub-Agent Delegation

Use the Task tool to delegate to Sonnet with appropriate agent prompts:
```markdown
Task: Create comprehensive tests for [feature]
Agent: Sonnet
System Prompt: .claude/agents/red-agent.md
```

Progress tracking occurs in:
- `.claude/artifacts/current-state.json`: Overall project state
- `.claude/artifacts/tdd-checkpoint.json`: TDD cycle progress
- `.claude/artifacts/test-results/`: Historical test execution