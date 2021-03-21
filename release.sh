#!/bin/sh

flutter build appbundle --obfuscate --split-debug-info=debug-info/android --no-sound-null-safety
flutter build ios --obfuscate --split-debug-info=debug-info/ios --no-sound-null-safety
