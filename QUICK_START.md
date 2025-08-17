# 🚀 Quick Start: Autonomous TDD with Solution Selection

## How It Works

1. **You provide a requirement** → "I need real-time chat"
2. **Claude presents 3 solutions** → Simple/Balanced/Advanced
3. **You select one** → "Let's go with option 2"
4. **Claude autonomously implements** using TDD via Sonnet sub-agents
5. **You get working, tested code** → Ready for production

## Example Session

### Your Input:
```markdown
I need to build a C# MAUI app that:
- Captures audio from microphone
- Streams to an API
- Integrates with OpenAI Whisper
- Shows live transcription
```

### Claude's Response:
```markdown
## Requirement: Real-time Audio Transcription App

### 🔵 Solution 1: Simple Recording & Upload
**Approach**: Record complete audio, then upload for processing
**Tech Stack**: MAUI MediaRecorder, REST API, Whisper API
**Pros**: Simple implementation, Reliable, Easy debugging
**Cons**: No real-time feedback, Higher latency
**Time**: 2-3 days

### 🟢 Solution 2: Chunked Streaming ⭐ Recommended
**Approach**: Stream audio chunks via WebSocket for near real-time processing
**Tech Stack**: MAUI Audio API, WebSocket, Whisper Python wrapper
**Pros**: Near real-time, Good UX, Reasonable complexity
**Cons**: Network dependency, Moderate complexity
**Time**: 4-5 days

### 🟡 Solution 3: Edge Processing
**Approach**: On-device processing with Whisper model
**Tech Stack**: MAUI, TensorFlow Lite, Whisper Mobile
**Pros**: True real-time, Offline capable, Privacy
**Cons**: Large app size, Device requirements, Complex
**Time**: 7-10 days

Please select: 1, 2, or 3?
```

### Your Selection:
```markdown
2
```

### Claude's Autonomous Execution:
```markdown
Excellent choice! Implementing chunked streaming solution...

🔴 RED Phase - Creating Tests [Delegating to Sonnet]
   ✅ Created 23 unit tests
   ✅ Created 8 integration tests
   ✅ Created 3 E2E tests
   
🟢 GREEN Phase - Implementation [Delegating to Sonnet]
   ✅ AudioCaptureService implemented
   ✅ WebSocketStreamer implemented
   ✅ WhisperIntegration implemented
   ✅ All 34 tests passing

🔵 REFACTOR Phase - Optimization [Delegating to Sonnet]
   ✅ Applied SOLID principles
   ✅ Removed code duplication
   ✅ Improved error handling
   ✅ All tests still passing

✅ INTEGRATION Phase - System Verification
   ✅ Android build successful
   ✅ Windows build successful
   ✅ API integration tested
   ✅ 87% code coverage

Implementation complete! The app is functional and tested.
Would you like to review the code or proceed with UI enhancements?
```

## Key Commands

### Start a new feature:
```markdown
"I need [specific feature description]"
```

### Select a solution:
```markdown
"2" (or "1" or "3")
```

### Request specific implementation:
```markdown
"Implement option 2 with extra focus on error handling"
```

### Review progress:
```markdown
"Show me the current test results"
```

## File Structure After Implementation

```
YourProject/
├── MASTER_PROMPT_V2.md      # The system prompt
├── CLAUDE.md                # Current project state
├── .claude/
│   ├── agents/              # Sub-agent definitions
│   │   ├── red-agent.md     # Test creation specialist
│   │   ├── green-agent.md   # Minimal implementation
│   │   └── solution-architect.md
│   ├── hooks/               # Automation scripts
│   │   └── autonomous-tdd.sh
│   ├── artifacts/           # Progress tracking
│   │   ├── current-tdd-status.json
│   │   └── tdd-checkpoint.json
│   └── mcp-tools/          # Tool configurations
│       └── solution-selector.json
└── src/
    ├── YourApp.Core/        # Business logic (with tests)
    ├── YourApp.MAUI/        # UI layer
    ├── YourApp.API/         # Backend services
    └── YourApp.Tests/       # All test projects
```

## Autonomous Features

### What Claude Does Automatically:
- ✅ Generates comprehensive tests
- ✅ Implements code to pass tests
- ✅ Refactors for quality
- ✅ Runs integration tests
- ✅ Maintains documentation
- ✅ Tracks progress in artifacts
- ✅ Ensures code coverage > 80%

### What Claude Asks You:
- 🤔 Which solution to implement (1, 2, or 3)
- 🤔 Approval for architecture changes
- 🤔 Confirmation at major milestones
- 🤔 Clarification on ambiguous requirements

## Sub-Agent Roles

| Agent | Role | When Used |
|-------|------|-----------|
| **Solution Architect** | Present 3 options | Every new requirement |
| **Red Agent (Sonnet)** | Create failing tests | Start of TDD cycle |
| **Green Agent (Sonnet)** | Minimal implementation | After tests created |
| **Refactor Agent (Sonnet)** | Improve code quality | After tests pass |
| **Integration Agent (Sonnet)** | System verification | End of cycle |

## Tips for Best Results

### Be Specific:
```markdown
❌ "Add authentication"
✅ "Add JWT-based authentication with refresh tokens, 1-hour expiry"
```

### Provide Context:
```markdown
❌ "Make it faster"
✅ "Optimize the search to return results in under 200ms for 10k records"
```

### State Constraints:
```markdown
❌ "Build a dashboard"
✅ "Build a dashboard using our existing React components, must work on mobile"
```

## Monitoring Progress

### Check Current Status:
```bash
cat .claude/artifacts/current-tdd-status.json | jq
```

### View Test Results:
```bash
dotnet test
```

### See Coverage:
```bash
dotnet test /p:CollectCoverage=true
```

## Common Workflows

### Adding a Feature:
1. Describe the feature
2. Select from 3 solutions
3. Let autonomous TDD run
4. Review and approve

### Fixing a Bug:
1. Describe the bug with reproduction steps
2. Claude creates failing test first
3. Implements fix
4. Verifies all tests pass

### Refactoring:
1. Identify code to refactor
2. Claude ensures tests exist
3. Refactors with test safety net
4. Confirms no regression

## Next Steps

1. **Start with**: "Create the initial MAUI project structure with a hello world test"
2. **Then add features**: "Add microphone permission handling"
3. **Build incrementally**: Each feature fully tested before the next
4. **Stay functional**: Never move forward with failing tests

---

Remember: You're the architect making decisions, Claude presents options, and Sonnet agents handle the implementation. This keeps you in control while automating the tedious parts of TDD!