#!/bin/sh

flutter pub run easy_localization:generate
flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart
sed -i -- "s/Map<String,dynamic>/Map<String,String>/g" ./lib/generated/codegen_loader.g.dart