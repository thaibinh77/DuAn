import 'package:flutter/material.dart';
import '../providers/banner_provider.dart';
import 'item/item_slider_widget.dart';

class Carousel extends StatefulWidget {
  final Function(int) onIndexChanged;
  const Carousel({Key? key, required this.onIndexChanged}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<Carousel> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  int _currentIndex = 0;
  int current = 0;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _fadeInAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_fadeController);

    _slideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(_slideController);

    _startAnimationLoop();
  }

  void _startAnimationLoop() async {
    while (true) {
      await Future.delayed(Duration(seconds: 4));

      _slideController.forward().orCancel;
      _fadeController.forward().orCancel;


      await _slideController.forward().orCancel;

      current = (_currentIndex + 1) % listCarousel.length;
      widget.onIndexChanged(current);

      await _fadeController.reverse().orCancel;

      _currentIndex = (_currentIndex + 1) % listCarousel.length;
      widget.onIndexChanged(_currentIndex); // Update index here

      // Update to the new image without setState, restart controllers
      _slideController.reset();
      _fadeController.forward().orCancel;
      await _fadeController.reverse().orCancel;
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _fadeInAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeInAnimation.value,
              child: listCarousel[_currentIndex],
            );
          },
        ),
        AnimatedBuilder(
          animation: _slideAnimation,
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimation,
              child: listCarousel[(_currentIndex + 1) % listCarousel.length],
            );
          },
        ),
      ],
    );
  }
}
