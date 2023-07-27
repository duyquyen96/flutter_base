import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct({super.key});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('assets/images/1.png'),
          Text('name'),
          Text('price'),
        ],
      ),
    );
  }
}
