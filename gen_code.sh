#!/bin/sh

flutter pub run easy_localization:generate
flutter pub run easy_localization:generate -f keys -s en.json -o locale_keys.g.dart

# Was used to remove a warning, seems to not be usefull anymore
#sed -i -- "s/Map<String,dynamic>/Map<String,String>/g" ./lib/generated/codegen_loader.g.dart