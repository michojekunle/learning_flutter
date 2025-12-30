import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harmonia',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HarmoniaSplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HarmoniaSplashScreen extends StatefulWidget {
  const HarmoniaSplashScreen({super.key});

  @override
  State<HarmoniaSplashScreen> createState() => _HarmoniaSplashScreenState();
}

class _HarmoniaSplashScreenState extends State<HarmoniaSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _textController;
  late AnimationController _progressController;
  late AnimationController _glowController;

  late Animation<double> _iconBounce;
  late Animation<double> _iconScale;
  late Animation<double> _iconRotation;
  late Animation<double> _textFade;
  late Animation<double> _subtitleFade;
  late Animation<double> _progress;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();

    // Icon animation controller
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Progress bar controller
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Glow effect controller
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    // Icon bounce animation with elastic effect
    _iconBounce = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: Curves.elasticOut,
      ),
    );

    // Icon scale animation
    _iconScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Icon rotation animation
    _iconRotation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: Curves.easeOut,
      ),
    );

    // Text fade animations
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeIn,
      ),
    );

    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    // Progress animation
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ),
    );

    // Glow animation
    _glow = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations
    Future.delayed(const Duration(milliseconds: 300), () {
      _iconController.forward();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _textController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      _progressController.forward();
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();
    _progressController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A2C2A),
              Color(0xFF3D2320),
              Color(0xFF2D1715),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Icon
                      AnimatedBuilder(
                        animation: _iconController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _iconBounce.value),
                            child: Transform.scale(
                              scale: _iconScale.value,
                              child: Transform.rotate(
                                angle: _iconRotation.value,
                                child: AnimatedBuilder(
                                  animation: _glowController,
                                  builder: (context, child) {
                                    return Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFFF8C42)
                                                .withOpacity(_glow.value),
                                            blurRadius: 40,
                                            spreadRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2B2B2B),
                                          borderRadius: BorderRadius.circular(40),
                                          border: Border.all(
                                            color: const Color(0xFF3D3D3D),
                                            width: 2,
                                          ),
                                        ),
                                        child: const Center(
                                          child: MusicNoteIcon(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      // App Name with fade-in
                      AnimatedBuilder(
                        animation: _textController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _textFade.value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - _textFade.value)),
                              child: const Text(
                                'Harmonia',
                                style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      // Subtitle with sparkle effect
                      AnimatedBuilder(
                        animation: _textController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _subtitleFade.value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - _subtitleFade.value)),
                              child: ShaderMask(
                                shaderCallback: (bounds) {
                                  return const LinearGradient(
                                    colors: [
                                      Color(0xFFD4A574),
                                      Color(0xFFFFD700),
                                      Color(0xFFD4A574),
                                    ],
                                  ).createShader(bounds);
                                },
                                child: const Text(
                                  'Scripture in Song',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Loading section at bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  children: [
                    const Text(
                      'INITIALIZING AI...',
                      style: TextStyle(
                        color: Color(0xFF8B7355),
                        fontSize: 12,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Animated progress bar
                    AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return Container(
                          width: 200,
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3D2320),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: 200 * _progress.value,
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF6B35),
                                      Color(0xFFFF8C42),
                                      Color(0xFFFFAA5C),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFF8C42)
                                          .withOpacity(0.5),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'v1.0.0',
                      style: TextStyle(
                        color: Color(0xFF6B5344),
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Music Note Icon Widget
class MusicNoteIcon extends StatelessWidget {
  const MusicNoteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(80, 80),
      painter: MusicNotePainter(),
    );
  }
}

class MusicNotePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFFAA5C),
          Color(0xFFFF8C42),
          Color(0xFFFF6B35),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    // Draw musical note
    // Note stem
    path.moveTo(size.width * 0.55, size.height * 0.25);
    path.lineTo(size.width * 0.55, size.height * 0.65);
    path.lineTo(size.width * 0.62, size.height * 0.65);
    path.lineTo(size.width * 0.62, size.height * 0.25);
    path.close();

    // Note head (circle)
    final noteHeadCenter = Offset(size.width * 0.50, size.height * 0.70);
    path.addOval(
      Rect.fromCenter(
        center: noteHeadCenter,
        width: size.width * 0.20,
        height: size.height * 0.15,
      ),
    );

    // Flag
    final flagPath = Path();
    flagPath.moveTo(size.width * 0.62, size.height * 0.25);
    flagPath.cubicTo(
      size.width * 0.75,
      size.height * 0.28,
      size.width * 0.80,
      size.height * 0.35,
      size.width * 0.75,
      size.height * 0.45,
    );
    flagPath.cubicTo(
      size.width * 0.70,
      size.height * 0.42,
      size.width * 0.65,
      size.height * 0.40,
      size.width * 0.62,
      size.height * 0.38,
    );
    flagPath.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(flagPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}