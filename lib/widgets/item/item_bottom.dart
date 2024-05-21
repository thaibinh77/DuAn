import 'package:flutter/material.dart';

class ItemBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: MediaQuery.of(context).size.height * 0.105,
      height: MediaQuery.of(context).size.height * 0.105,
    );
  }
}
