import 'dart:math';

import 'package:flutter/material.dart';

class ItemTestWidget extends StatefulWidget {
  final String image1;
  final String image2;
  final String image3;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  const ItemTestWidget({
    Key? key,
    required this.image1,
    required this.image2,
    required this.image3,
    this.onPressed1,
    this.onPressed2,
  }) : super(key: key);

  @override
  _ItemTestWidgetState createState() => _ItemTestWidgetState();
}

class _ItemTestWidgetState extends State<ItemTestWidget> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> animation1;

  late AnimationController _controller2;
  late Animation<double> animation2;

  @override
  void initState() {
    super.initState();
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(_controller2!)
      ..addListener(() {
        setState(() {});
      });

    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation1 = Tween<double>(begin: 1.0, end: 0.0).animate(_controller1!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void handleImage1Tap() {
    _controller2.reverse().then((value) {
      if (widget.onPressed1 != null) {
        widget.onPressed1!();
      }
    });
  }

  void handleImage2Tap() {
    _controller2.forward(from: 0.0).then((value) {
      if (widget.onPressed2 != null) {
        widget.onPressed2!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = constraints.maxWidth / 2;

        return Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: itemWidth,
            child: Row(
              children: [
                widget.onPressed1 == null ?
                Expanded(
                  child: Image.asset(
                    widget.image1,
                    fit: BoxFit.fill,
                  ),
                )
                : Expanded(
                  child: GestureDetector(
                    onTap: handleImage1Tap,
                    child: Container(
                      width: itemWidth,
                      child: AnimatedBuilder(
                        animation: _controller1,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.0015)
                              ..rotateY(pi * (1-animation1.value)),
                            child: animation2.value <= 0.5 ?
                            Image.asset(
                              widget.image1,
                              fit: BoxFit.fill,
                            )
                                : Image.asset(
                              widget.image2,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                widget.onPressed2 == null ?
                  Expanded(
                    child: Image.asset(
                      widget.image2,
                      fit: BoxFit.fill,
                    ),
                  )
                : Expanded(
                  child: GestureDetector(
                    onTap: handleImage2Tap,
                    child: Container(
                      width: itemWidth, // Đặt kích thước cố định cho ảnh
                      child: AnimatedBuilder(
                        animation: _controller2,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.0015)
                              ..rotateY(pi * animation2.value),
                            child: animation2.value <= 0.5 ?
                            Image.asset(
                              widget.image2,
                              fit: BoxFit.fill,
                            )
                            : Image.asset(
                              widget.image3,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
