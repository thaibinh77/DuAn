import 'package:flutter/material.dart';

class ItemMenuWidget extends StatefulWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;

  const ItemMenuWidget({
    Key? key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
  }) : super(key: key);

  @override
  _ItemMenuWidgetState createState() => _ItemMenuWidgetState();
}

class _ItemMenuWidgetState extends State<ItemMenuWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image 1
        Positioned.fill(
          child: Image.asset(
            widget.image1,
            fit: BoxFit.cover,
          ),
        ),
        // Image 2
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateY(-_animation.value * 3.14 / 2),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 1 - _animation.value,
                  child: Image.asset(
                    widget.image2,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        // Image 3
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: Image.asset(
                  widget.image3,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        // Image 4
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: Transform.translate(
                  offset: Offset(0.0, 100.0 * (1 - _animation.value)),
                  child: Image.asset(
                    widget.image4,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flip Image Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var item in listCarousel)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: item,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<ItemMenuWidget> listCarousel = [
  ItemMenuWidget(
    image1: "assets/images/menu_1.png",
    image2: "assets/images/menu_2.png",
    image3: "assets/images/menu_3.png",
    image4: "assets/images/menu_4.png",
  ),
  ItemMenuWidget(
    image1: "assets/images/menu_5.png",
    image2: "assets/images/menu_6.png",
    image3: "assets/images/menu_7.png",
    image4: "assets/images/menu_8.png",
  ),
  ItemMenuWidget(
    image1: "assets/images/menu_9.png",
    image2: "assets/images/menu_10.png",
    image3: "assets/images/menu_11.png",
    image4: "assets/images/menu_12.png",
  ),
];
