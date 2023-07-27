

import 'package:flutter/material.dart';

class KeyboardVisibilityListener extends StatefulWidget {
  final Widget child;
  final void Function(bool isKeyboardVisible) listener;

  const KeyboardVisibilityListener({
    super.key,
    required this.child,
    required this.listener,
  });

  @override
  State<KeyboardVisibilityListener> createState() =>
      _KeyboardVisibilityListenerState();
}

class _KeyboardVisibilityListenerState extends State<KeyboardVisibilityListener>
    with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final visible = bottomInset > 0.0;
    if (visible != _isKeyboardVisible) {
      _isKeyboardVisible = visible;
      widget.listener(_isKeyboardVisible);
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}