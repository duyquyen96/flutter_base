// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../widgets/message.dart';
import 'modal.dart';

rebuildAllWidget() async {
  await WidgetsBinding.instance.performReassemble();
}

functionInDevelopment() {
  showModal(const Message(
    content: 'Chức năng đang phát triển!',
  ));
}
