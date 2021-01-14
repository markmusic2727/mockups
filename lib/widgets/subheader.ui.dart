import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mockups/services/mapGradient.service.dart';
import 'package:mockups/utils/constants.dart';

class Subheader extends StatefulWidget {
  @override
  _SubheaderState createState() => _SubheaderState();
}

class _SubheaderState extends State<Subheader> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation1;
  Animation animation2;
  int currentImage = 3;
  List<Color> colors;
  void animate() {
    List<Color> fromPointer = MapGradient.generateColors(currentImage);
    List<Color> toPointer = MapGradient.generateColors(currentImage - 1);

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    animation1 = ColorTween(begin: fromPointer[0], end: toPointer[0])
        .animate(controller);
    animation2 = ColorTween(begin: fromPointer[1], end: toPointer[1])
        .animate(controller);

    controller.forward(from: 0);

    controller.addListener(() {
      setState(() {
        colors = <Color>[animation1.value, animation2.value];
      });
    });
  }

  @override
  void initState() {
    animate();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        SelectableText('An online repository of ', style: kSubheader),
        SelectableText(
          '4k',
          style: kSubheader.copyWith(
            foreground: Paint()
              ..shader = LinearGradient(
                colors: colors ?? MapGradient.generateColors(currentImage),
              ).createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
          ),
        ),
        SelectableText(' device mockups.', style: kSubheader),
      ],
    );
  }
}
