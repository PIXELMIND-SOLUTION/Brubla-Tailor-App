import 'package:brubla_tailor/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _shimmerController;
  late AnimationController _threadController;
  late AnimationController _textController;
  late AnimationController _pulseController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoRotation;
  late Animation<double> _shimmerAnim;
  late Animation<double> _threadProgress;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _taglineOpacity;
  late Animation<Offset> _taglineSlide;
  late Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();

    // Logo entrance animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _logoRotation = Tween<double>(begin: -0.3, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    // Shimmer sweep
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _shimmerAnim = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    // Thread drawing animation
    _threadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _threadProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _threadController, curve: Curves.easeInOut),
    );

    // Text animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    // Pulse glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Sequence
    _logoController.forward().then((_) {
      _shimmerController.forward();
      _threadController.forward();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _textController.forward();
    });


    Future.delayed(const Duration(milliseconds: 3200), () {
  if (mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
});
  }

  @override
  void dispose() {
    _logoController.dispose();
    _shimmerController.dispose();
    _threadController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: Stack(
        children: [
          // Background texture dots
          CustomPaint(
            size: Size(size.width, size.height),
            painter: _BackgroundPatternPainter(),
          ),

          // Radial glow behind logo
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              return Center(
                child: Transform.scale(
                  scale: _pulseScale.value,
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFD4AF37).withOpacity(0.12),
                          const Color(0xFFD4AF37).withOpacity(0.04),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Animated thread lines
          AnimatedBuilder(
            animation: _threadProgress,
            builder: (context, _) {
              return CustomPaint(
                size: Size(size.width, size.height),
                painter: _ThreadPainter(
                  progress: _threadProgress.value,
                  center: Offset(size.width / 2, size.height / 2 - 40),
                ),
              );
            },
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Logo with animations
                AnimatedBuilder(
                  animation: Listenable.merge(
                      [_logoController, _shimmerController]),
                  builder: (context, _) {
                    return Transform.rotate(
                      angle: _logoRotation.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: Opacity(
                          opacity: _logoOpacity.value,
                          child: _buildLogoWithShimmer(),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 36),

                // Brand name
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, _) {
                    return SlideTransition(
                      position: _textSlide,
                      child: FadeTransition(
                        opacity: _textOpacity,
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color(0xFFD4AF37),
                                  Color(0xFFF5E27A),
                                  Color(0xFFD4AF37),
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                'BRUBLA',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 10,
                                  fontFamily: 'serif',
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Divider line with dots
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _dot(),
                                _line(),
                                _diamond(),
                                _line(),
                                _dot(),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Tagline
                            SlideTransition(
                              position: _taglineSlide,
                              child: FadeTransition(
                                opacity: _taglineOpacity,
                                child: const Text(
                                  'TAILORED TO PERFECTION',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF8A8A8A),
                                    letterSpacing: 5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Bottom loader bar
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _threadProgress,
                  builder: (context, _) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Column(
                        children: [
                          // Progress bar
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              color: const Color(0xFF222222),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: _threadProgress.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFD4AF37),
                                      Color(0xFFF5E27A),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _threadProgress.value < 0.5
                                ? 'Preparing your experience...'
                                : 'Almost ready...',
                            style: const TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 11,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoWithShimmer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Gold ring
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, _) {
            return Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                  width: 1,
                ),
              ),
            );
          },
        ),

        // Outer dashed ring
        CustomPaint(
          size: const Size(190, 190),
          painter: _DashedCirclePainter(),
        ),

        // Logo container
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF111111),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD4AF37).withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 20,
                spreadRadius: -5,
              ),
            ],
          ),
          child: ClipOval(
            child: ShaderMask(
              shaderCallback: (bounds) {
                final shimmerX = _shimmerAnim.value * bounds.width;
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white.withOpacity(0.6),
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [
                    0.0,
                    (shimmerX / bounds.width).clamp(0.0, 1.0) - 0.15,
                    (shimmerX / bounds.width).clamp(0.0, 1.0),
                    (shimmerX / bounds.width).clamp(0.0, 1.0) + 0.15,
                    1.0,
                  ],
                ).createShader(bounds);
              },
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dot() => Container(
        width: 4,
        height: 4,
        decoration: const BoxDecoration(
          color: Color(0xFFD4AF37),
          shape: BoxShape.circle,
        ),
      );

  Widget _diamond() => Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: 5,
          height: 5,
          color: const Color(0xFFD4AF37),
        ),
      );

  Widget _line() => Container(
        width: 40,
        height: 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        color: const Color(0xFFD4AF37).withOpacity(0.6),
      );
}

// Background dot pattern
class _BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..strokeWidth = 1;

    const spacing = 30.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.8, paint);
      }
    }

    // Corner accent lines
    final accentPaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.08)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Top-left corner bracket
    canvas.drawPath(
      Path()
        ..moveTo(20, 60)
        ..lineTo(20, 20)
        ..lineTo(60, 20),
      accentPaint,
    );

    // Top-right corner bracket
    canvas.drawPath(
      Path()
        ..moveTo(size.width - 60, 20)
        ..lineTo(size.width - 20, 20)
        ..lineTo(size.width - 20, 60),
      accentPaint,
    );

    // Bottom-left corner bracket
    canvas.drawPath(
      Path()
        ..moveTo(20, size.height - 60)
        ..lineTo(20, size.height - 20)
        ..lineTo(60, size.height - 20),
      accentPaint,
    );

    // Bottom-right corner bracket
    canvas.drawPath(
      Path()
        ..moveTo(size.width - 60, size.height - 20)
        ..lineTo(size.width - 20, size.height - 20)
        ..lineTo(size.width - 20, size.height - 60),
      accentPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Animated thread/needle lines radiating from logo
class _ThreadPainter extends CustomPainter {
  final double progress;
  final Offset center;

  _ThreadPainter({required this.progress, required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;

    final angles = [
      -math.pi / 6,
      math.pi / 6,
      math.pi / 2,
      5 * math.pi / 6,
      7 * math.pi / 6,
      3 * math.pi / 2,
    ];

    final colors = [
      const Color(0xFFD4AF37).withOpacity(0.15),
      const Color(0xFFD4AF37).withOpacity(0.1),
      const Color(0xFFD4AF37).withOpacity(0.12),
      const Color(0xFFD4AF37).withOpacity(0.08),
      const Color(0xFFD4AF37).withOpacity(0.15),
      const Color(0xFFD4AF37).withOpacity(0.1),
    ];

    final lengths = [180.0, 150.0, 200.0, 160.0, 170.0, 140.0];

    for (int i = 0; i < angles.length; i++) {
      paint.color = colors[i];
      final endX = center.dx + math.cos(angles[i]) * lengths[i] * progress;
      final endY = center.dy + math.sin(angles[i]) * lengths[i] * progress;
      canvas.drawLine(center, Offset(endX, endY), paint);

      // Small circle at end
      if (progress > 0.8) {
        final dotPaint = Paint()
          ..color = const Color(0xFFD4AF37)
              .withOpacity(0.3 * ((progress - 0.8) / 0.2))
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(endX, endY), 2, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ThreadPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// Dashed circle painter
class _DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.2)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    const dashCount = 36;
    const dashLength = 0.12;
    const gapLength = 0.06;
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * (dashLength + gapLength)) * math.pi;
      final sweepAngle = dashLength * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 1),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}