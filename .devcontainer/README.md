# Flutter Dev Container Setup

This project includes a complete Flutter development environment using VS Code Dev Containers.

## Features

- **Flutter SDK**: Pre-installed Flutter 3.27.1
- **Android SDK**: Complete Android development setup with API 33 & 34
- **Java 17**: OpenJDK 17 for Android development
- **VS Code Extensions**: Dart, Flutter, and Java development extensions
- **ADB Configuration**: Properly configured for dev container environment
- **Build Tools**: All necessary build tools including CMake, Ninja, etc.

## Quick Start

1. **Open in Dev Container**: VS Code will prompt to reopen in container
2. **Wait for Setup**: Initial setup runs automatically via `postCreateCommand`
3. **Start Development**: Use the provided tasks and launch configurations

## Available Tasks

Access these via `Ctrl+Shift+P` → "Tasks: Run Task":

- **Flutter: Get Dependencies** - Install project dependencies
- **Flutter: Run (Debug)** - Run app in debug mode with software rendering
- **Flutter: Run (Release)** - Run app in release mode
- **Flutter: Build APK** - Build release APK
- **Flutter: Clean** - Clean build artifacts
- **Flutter: Test** - Run unit tests
- **Android: Start Emulator** - Start Android emulator
- **ADB: Reset Server** - Fix ADB connection issues
- **Flutter: Doctor** - Check Flutter installation

## Launch Configurations

Use `F5` or the Run panel:

- **Flutter (Debug)** - Debug with software rendering enabled
- **Flutter (Release)** - Release mode debugging
- **Flutter (Profile)** - Profile mode for performance analysis

## Troubleshooting

### ADB Connection Issues
If you see ADB connection errors:
1. Run the "ADB: Reset Server" task
2. Or manually run: `unset ANDROID_ADB_SERVER_PORT && adb kill-server && adb start-server`

### Emulator Issues
- The container includes an Android emulator configured for x86_64
- Use the "Android: Start Emulator" task to start it
- For performance, software rendering is enabled by default

### VM Service Connection Issues
- Software rendering is enabled by default to avoid GPU/Vulkan issues
- The `--enable-software-rendering` flag is added to debug configurations

## Container Configuration

The dev container includes:

- **Privileged mode**: Required for Android emulator
- **Network host mode**: For proper ADB connectivity
- **Port forwarding**: 5037 (ADB), 8080, 8888, 9000
- **Volume mounts**: Android configuration persistence

## Environment Variables

Pre-configured in the container:

- `FLUTTER_ROOT=/usr/lib/flutter`
- `ANDROID_HOME=/usr/lib/android-sdk`
- `ANDROID_SDK_ROOT=/usr/lib/android-sdk`
- `JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64`

## Custom Scripts

- `start-emulator` - Start Android emulator with optimized settings
- `flutter-run` - Run Flutter with software rendering enabled

## Notes

- First container build may take 10-15 minutes due to Flutter/Android SDK downloads
- Subsequent starts are much faster
- The container persists Android configuration via volume mounts
- Chrome is included for Flutter web development
