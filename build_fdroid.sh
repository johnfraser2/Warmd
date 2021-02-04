#!/bin/sh

# We remove references to the in_app_review dependency for fdroid build
sed -i 's/.*in_app_review.*//' pubspec.yaml
git apply ./fdroid.patch

flutter build apk