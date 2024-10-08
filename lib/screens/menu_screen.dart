import 'package:flutter/material.dart';

import '../widgets/carousel_menu_widget.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  static const routeName = '/menu-screen';

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: CarouselMenuWidget(),
    );
  }
}
