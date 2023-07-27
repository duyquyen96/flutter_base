



import 'package:flutter/material.dart';

class SizeListener extends StatefulWidget {
  const SizeListener({super.key, required this.child, required this.listener});

  final Widget child;
  final void Function(Size size) listener;

  @override
  State<SizeListener> createState() => _SizeListenerState();
}

class _SizeListenerState extends State<SizeListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.listener(context.size!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}