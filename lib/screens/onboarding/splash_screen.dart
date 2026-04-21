import 'package:flutter/material.dart';
import 'dart:async';
import 'package:responsi1apb/screens/auth/loginjob.dart';
import 'get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _circleController;
  late AnimationController _textController;

  late Animation<double> _scale;
  late Animation<double> _fade;
  late Animation<double> _translate;

  late Animation<double> _textOpacity;
  late Animation<double> _textScale;

  @override
  void initState() {
    super.initState();

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOutBack),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(_circleController);

    _translate = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _textOpacity = Tween<double>(begin: 0, end: 1).animate(_textController);

    _textScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _circleController.forward();

    Future.delayed(const Duration(milliseconds: 700), () {
      _textController.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStartedScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _circleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7F3DFF),
              Color(0xFF5F2EEA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _circleController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _translate.value),
                child: Opacity(
                  opacity: _fade.value,
                  child: Transform.scale(
                    scale: _scale.value,
                    child: child,
                  ),
                ),
              );
            },
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 25,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textOpacity.value,
                      child: Transform.scale(
                        scale: _textScale.value,
                        child: child,
                      ),
                    );
                  },
                  child: const Text(
                    'J',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7F3DFF),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}