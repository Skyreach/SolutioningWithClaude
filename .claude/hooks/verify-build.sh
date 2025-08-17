#!/bin/bash
# Verify Build Hook - Ensures project builds for all target platforms

echo "🏗️  Verifying build status..."

# Function to check build result
check_build() {
    if [ $? -eq 0 ]; then
        echo "✅ $1 build successful!"
        return 0
    else
        echo "❌ $1 build failed!"
        return 1
    fi
}

BUILD_SUCCESS=true

# Check for .NET project
if [ -f *.sln ] || [ -f *.csproj ]; then
    # Try to build the solution
    echo "📦 Building solution..."
    dotnet build --no-restore --verbosity quiet
    check_build "Solution" || BUILD_SUCCESS=false
    
    # Check for MAUI project
    if find . -name "*.csproj" -exec grep -l "Microsoft.Maui" {} \; | grep -q .; then
        echo "📱 Found MAUI project, checking platform builds..."
        
        # Check Windows build (if on Windows or WSL)
        if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ -f /proc/version ]] && grep -qi microsoft /proc/version; then
            echo "🪟 Checking Windows build..."
            dotnet build -f net8.0-windows10.0.19041.0 --no-restore --verbosity quiet
            check_build "Windows" || BUILD_SUCCESS=false
        fi
        
        # Check Android build
        echo "🤖 Checking Android build..."
        dotnet build -f net8.0-android --no-restore --verbosity quiet
        check_build "Android" || BUILD_SUCCESS=false
    fi
    
    # Run tests
    echo "🧪 Running tests..."
    dotnet test --no-build --verbosity quiet
    check_build "Tests" || BUILD_SUCCESS=false
else
    echo "⚠️  No .NET solution found."
fi

if [ "$BUILD_SUCCESS" = true ]; then
    echo "✅ All builds verified successfully!"
    exit 0
else
    echo "❌ Build verification failed. Please fix errors before proceeding."
    exit 1
fi