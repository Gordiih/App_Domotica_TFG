import 'package:flutter/material.dart';
import 'dart:async';

class TapAnimat extends StatefulWidget {
  final double size;

  const TapAnimat({
    super.key,
    this.size = 40,
  });

  @override
  State<TapAnimat> createState() => _TapAnimatState();
}

class _TapAnimatState extends State<TapAnimat> {
  double opacity = 1.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        opacity = opacity == 1.0 ? 0.0 : 1.0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: Icon(
        Icons.touch_app,
        size: widget.size,
        color: Colors.black87,
      ),
    );
  }
}
