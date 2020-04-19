source <(antibody init)

export PATH="$PATH:$PWD/lib/android/build-tools"
export PATH="$PATH:$PWD/lib/android/platform-tools"
export PATH="$PATH:$PWD/lib/android/tools/bin"
export PATH="$PATH:$PWD/lib/flutter/bin"
export PATH="$PATH:$PWD/bin"

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

export ANDROID_HOME="$PWD/lib/android"

alias idea="intellij-idea-ultimate-edition"

source ~/.config/antibody/config
