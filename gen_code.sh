#!/bin/sh

flutter pub run intl_utils:generate
flutter pub run build_runner build --delete-conflicting-outputs