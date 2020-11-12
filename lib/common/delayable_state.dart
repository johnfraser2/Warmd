import 'dart:async';

import 'package:flutter/material.dart';

abstract class DelayableState<E extends StatefulWidget> extends State<E> with WidgetsBindingObserver {
  final _subscriptions = <StreamSubscription>{};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscriptions.forEach((f) => f.cancel());

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _subscriptions.forEach((f) => f.pause());
    } else if (state == AppLifecycleState.resumed) {
      _subscriptions.forEach((f) => f.resume());
    }
  }

  void delay(Duration duration, Function onDelayed) {
    StreamSubscription s;
    s = Future<void>.delayed(duration).asStream().listen((_) {
      _subscriptions.remove(s);

      onDelayed();
    });

    _subscriptions.add(s);
  }

  void delayMs(int ms, Function onDelayed) {
    delay(Duration(milliseconds: ms), onDelayed);
  }
}
