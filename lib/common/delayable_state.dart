import 'dart:async';

import 'package:flutter/material.dart';

abstract class DelayableState<E extends StatefulWidget> extends State<E> with WidgetsBindingObserver {
  final _subscriptions = <StreamSubscription>{};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      for (final subscription in _subscriptions) {
        subscription.pause();
      }
    } else if (state == AppLifecycleState.resumed) {
      for (final subscription in _subscriptions) {
        subscription.resume();
      }
    }
  }

  void delay(Duration duration, VoidCallback onDelayed) {
    late StreamSubscription s;
    s = Future<void>.delayed(duration).asStream().listen((_) {
      _subscriptions.remove(s);

      onDelayed();
    });

    _subscriptions.add(s);
  }

  void delayMs(int ms, VoidCallback onDelayed) {
    delay(Duration(milliseconds: ms), onDelayed);
  }
}
