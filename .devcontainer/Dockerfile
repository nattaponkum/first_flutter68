FROM ubuntu:20.04

# Avoid prompts from apt during build
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# Install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-17-jdk \
    wget \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    build-essential \
    file \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Download and install Android SDK
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk
ENV ANDROID_HOME=/usr/lib/android-sdk
RUN mkdir -p ${ANDROID_SDK_ROOT} && \
    cd ${ANDROID_SDK_ROOT} && \
    wget -O sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip sdk-tools.zip && \
    rm sdk-tools.zip && \
    mkdir -p cmdline-tools/latest && \
    mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true

# Set Android SDK environment
ENV PATH=${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/tools/bin:${PATH}

# Accept Android licenses and install SDK components
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-33" "platforms;android-34" "build-tools;33.0.1" "build-tools;34.0.0" "emulator" "system-images;android-33;google_apis;x86_64"

# Download and install Flutter
ENV FLUTTER_VERSION=3.27.1
ENV FLUTTER_ROOT=/usr/lib/flutter
RUN cd /usr/lib && \
    wget -O flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz && \
    tar xf flutter.tar.xz && \
    rm flutter.tar.xz

# Add Flutter to PATH
ENV PATH=${FLUTTER_ROOT}/bin:${PATH}

# Pre-download Flutter dependencies
RUN flutter precache && \
    flutter config --android-sdk ${ANDROID_SDK_ROOT} && \
    flutter config --no-analytics && \
    flutter doctor --android-licenses

# Create Android emulator
RUN echo "no" | avd create -n flutter_emulator -k "system-images;android-33;google_apis;x86_64" -d "pixel_4"

# Install Chrome for web development (optional)
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Set Chrome environment variable
ENV CHROME_EXECUTABLE=/usr/bin/google-chrome

# Create workspace directory
WORKDIR /workspaces

# Fix ADB server configuration
RUN mkdir -p /root/.android && \
    echo "export ADB_SERVER_SOCKET=tcp:127.0.0.1:5037" >> /root/.bashrc

# Create pub cache directory
RUN mkdir -p /root/.pub-cache

# Set permissions
RUN chmod -R 755 ${FLUTTER_ROOT} && \
    chmod -R 755 ${ANDROID_SDK_ROOT}

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Default command
CMD ["/bin/bash"]
