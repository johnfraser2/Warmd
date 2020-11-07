import 'package:flutter/material.dart';
import 'package:smart_text_view/smart_text_view.dart';
import 'package:url_launcher/url_launcher.dart';

const warmdLightBlue = Color(0xFFDFF3FE);
const warmdBlue = Color(0xFF00AAF2);
const warmdDarkBlue = Color(0xFF123079);

const warmdRed = Color(0xFFFF757D);

const warmdGreen = Color(0xFF7CCE17);

class Gaps {
  static const Widget h4 = SizedBox(height: 4);
  static const Widget h8 = SizedBox(height: 8);
  static const Widget h16 = SizedBox(height: 16);
  static const Widget h24 = SizedBox(height: 24);
  static const Widget h32 = SizedBox(height: 32);
  static const Widget h48 = SizedBox(height: 48);
  static const Widget h64 = SizedBox(height: 64);
  static const Widget h92 = SizedBox(height: 92);
  static const Widget h128 = SizedBox(height: 128);
  static const Widget w4 = SizedBox(width: 4);
  static const Widget w8 = SizedBox(width: 8);
  static const Widget w16 = SizedBox(width: 16);
  static const Widget w24 = SizedBox(width: 24);
  static const Widget w32 = SizedBox(width: 32);
  static const Widget w48 = SizedBox(width: 48);
  static const Widget w64 = SizedBox(width: 64);
  static const Widget w92 = SizedBox(width: 92);
  static const Widget w128 = SizedBox(width: 128);
}

extension ListExtension<E> on List<E> {
  List<E> clone() => List.from(this);

  Iterable<T> mapIndexed<T>(T Function(int idx, E element) f) => asMap()
      .map(
        (idx, element) => MapEntry(
          idx,
          f(idx, element),
        ),
      )
      .values;
}

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> sort([int Function(MapEntry<K, V> a, MapEntry<K, V> b) compare]) {
    var entries = this.entries.toList();
    entries.sort(compare);
    return Map<K, V>.fromEntries(entries);
  }
}

SmartText buildSmartText(BuildContext context, String text, {Color defaultColor, Color linkColor}) {
  return SmartText(
    linkStyle: Theme.of(context).textTheme.bodyText2.copyWith(
          color: linkColor ?? warmdDarkBlue,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w300,
        ),
    text: text,
    style: Theme.of(context).textTheme.bodyText2.copyWith(color: defaultColor ?? Colors.grey[500], fontWeight: FontWeight.w300),
    onOpen: (url) {
      launchUrl(url);
    },
  );
}

Widget buildBackButton(BuildContext context) {
  return Row(
    children: [
      InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Back',
            style: Theme.of(context).textTheme.subtitle1.copyWith(color: warmdDarkBlue, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    ],
  );
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
