#!/bin/bash

# Setup script that runs after container creation

echo "Setting up Flutter development environment..."

# Ensure Flutter is in PATH
export PATH="/usr/lib/flutter/bin:$PATH"

# Set Android SDK environment variables
export ANDROID_HOME="/usr/lib/android-sdk"
export ANDROID_SDK_ROOT="/usr/lib/android-sdk"

# Fix ADB server configuration for dev containers
echo "Configuring ADB for dev container..."
unset ANDROID_ADB_SERVER_PORT
adb kill-server 2>/dev/null || true
adb start-server

# Get Flutter dependencies for the current project
echo "Getting Flutter dependencies..."
flutter pub get

# Run Flutter doctor to check setup
echo "Running Flutter doctor..."
flutter doctor -v

# Create a simple script to start emulator if needed
cat > /usr/local/bin/start-emulator << 'EOF'
#!/bin/bash
echo "Starting Android Emulator..."
emulator -avd flutter_emulator -no-audio -no-window -gpu swiftshader_indirect -no-snapshot -wipe-data &
echo "Waiting for emulator to boot..."
adb wait-for-device
echo "Emulator is ready!"
EOF

chmod +x /usr/local/bin/start-emulator

# Create a script for Flutter run with proper configuration
cat > /usr/local/bin/flutter-run << 'EOF'
#!/bin/bash
echo "Running Flutter app with optimized settings..."
flutter run --enable-software-rendering --verbose
EOF

chmod +x /usr/local/bin/flutter-run

echo "Setup complete!"
echo ""
echo "Available commands:"
echo "  start-emulator    - Start the Android emulator"
echo "  flutter-run       - Run Flutter app with optimized settings"
echo "  flutter doctor    - Check Flutter installation"
echo ""
echo "To run your Flutter app:"
echo "1. start-emulator (if you need an emulator)"
echo "2. flutter-run"
