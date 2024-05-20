import 'dart:math';

import 'package:flutter/material.dart';

class ItemMenuWidget extends StatefulWidget {
  final String image1;
  final String image2;
  final VoidCallback? onPressed;
  final AnimationController? controller;

  const ItemMenuWidget({
    Key? key,
    required this.image1,
    required this.image2,
    this.onPressed,
    this.controller,
  }) : super(key: key);

  @override
  _ItemMenuWidgetState createState() => _ItemMenuWidgetState();
}

class _ItemMenuWidgetState extends State<ItemMenuWidget> with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller!.status == AnimationStatus.dismissed) {
          controller!.forward();
        } else {
          controller!.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(pi * animation.value),
            child: Card(
              child: animation.value <= 0.5
                  ? Container(
                width: 350,
                height: 300,
                child: Image.asset(widget.image1, fit: BoxFit.cover),
              )
                  : Container(
                width: 350,
                height: 300,
                child: Image.asset(widget.image2, fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}
