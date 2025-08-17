# CLAUDE.md - AI Assistant Configuration

## Project: AudioStreamer MAUI Application

### 🎯 Primary Objective
Build a C# MAUI application with real-time audio streaming to OpenAI Whisper, maintaining 100% functional state between all interactions.

### 📋 Current Sprint
**Goal**: Set up project structure with basic audio capture
**Status**: Not Started
**Last Verified**: N/A

### ✅ Verification Checklist
Before ANY code changes:
- [ ] Run existing tests: `dotnet test`
- [ ] Check build status: `dotnet build`
- [ ] Verify Android target: `dotnet build -f net8.0-android`

After EVERY change:
- [ ] Tests still pass
- [ ] Application builds
- [ ] No regression in existing features

### 🏗️ Architecture Decisions
| Component | Decision | Rationale | Verified |
|-----------|----------|-----------|----------|
| Audio Capture | MediaRecorder API | Native Android support | ❌ |
| Streaming | WebSocket | Low latency | ❌ |
| Whisper Integration | Python CLI | Simplest to start | ❌ |
| Testing Framework | NUnit | Familiar to .NET devs | ❌ |

### 🧪 Test Strategy
```
1. Unit Tests (AudioStreamer.Tests)
   - Business logic isolation
   - Mock external dependencies
   - Run on every change

2. Integration Tests (AudioStreamer.Tests.Integration)
   - API communication
   - Whisper CLI interaction
   - Run before commits

3. UI Tests (AudioStreamer.Tests.UI)
   - MAUI test framework
   - Critical path only
   - Run before release
```

### 🚀 Commands Reference
```bash
# Development
dotnet watch run -f net8.0-windows10.0.19041.0  # Windows UI testing
dotnet build -f net8.0-android                   # Android build check

# Testing
dotnet test                                       # All tests
dotnet test --filter "Category=Unit"            # Unit tests only
dotnet test --logger "console;verbosity=detailed" # Verbose output

# Deployment
dotnet publish -f net8.0-android -c Release     # Android APK
```

### 📁 Project Structure
```
AudioStreamer/
├── AudioStreamer.Core/          # Business logic
│   ├── Services/
│   │   ├── IAudioCapture.cs
│   │   ├── IStreamingService.cs
│   │   └── IWhisperService.cs
│   └── Models/
│       └── AudioChunk.cs
├── AudioStreamer.MAUI/          # UI Layer
│   ├── Platforms/Android/      # Android-specific
│   ├── Platforms/Windows/      # Windows-specific
│   └── ViewModels/
├── AudioStreamer.API/           # Backend API
│   └── Controllers/
│       └── AudioController.cs
└── AudioStreamer.Tests/         # Test projects
    ├── Unit/
    ├── Integration/
    └── UI/
```

### 🔄 Current Working Context
```csharp
// Last working code location
File: None
Method: None
Test: None

// Current task
Task: Initial project setup
Step: Create solution structure
Command to run next: dotnet new sln -n AudioStreamer
```

### 🐛 Known Issues
| Issue | Workaround | Fix Status |
|-------|------------|------------|
| None yet | - | - |

### 📊 Progress Tracking
```json
{
  "milestones": [
    {"id": 1, "name": "Project Setup", "status": "pending"},
    {"id": 2, "name": "Audio Capture", "status": "pending"},
    {"id": 3, "name": "Streaming Implementation", "status": "pending"},
    {"id": 4, "name": "Whisper Integration", "status": "pending"},
    {"id": 5, "name": "UI Implementation", "status": "pending"}
  ]
}
```

### 🔐 Security Considerations
- No API keys in source code
- Use environment variables for sensitive data
- Implement proper audio permissions handling
- Sanitize all user inputs

### 🎨 UI/UX Guidelines
- Material Design 3 for Android
- Fluent Design for Windows
- Accessibility: WCAG 2.1 AA compliance
- Responsive layout for different screen sizes

### 🚦 Git Workflow
```bash
# Feature branch
git checkout -b feature/audio-capture

# After tests pass
git add .
git commit -m "feat: implement audio capture with tests"

# Never commit if tests fail!
```

### 📝 User Verification Points
1. **After project creation**: Can you build the solution?
2. **After test setup**: Do all initial tests pass?
3. **After audio implementation**: Does microphone permission request work?
4. **After streaming setup**: Can you see WebSocket connection established?
5. **After Whisper integration**: Does transcription return text?

### 🤖 AI Assistant Reminders
- **NEVER** proceed without passing tests
- **ALWAYS** ask for verification at milestones
- **CREATE** minimal reproducible examples for issues
- **MAINTAIN** this file with current state
- **ROLLBACK** immediately if build breaks

### 📅 Session History
| Date | Achievement | Tests | Build | Verified |
|------|-------------|-------|-------|----------|
| [Date] | Created project structure | N/A | N/A | ⏳ |

### 💡 Next Actions
1. Create solution and project structure
2. Set up initial test project with smoke test
3. Verify build for both Windows and Android targets
4. Get user confirmation before proceeding

---
**Remember**: Every line of code must have a purpose, a test, and user verification.