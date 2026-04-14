import 'package:brubla_tailor/views/auth/register_screen.dart';
import 'package:brubla_tailor/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;

  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;
  late Animation<double> _pulseAnim;
  late Animation<double> _shimmerAnim;

  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
      List.generate(4, (_) => FocusNode());

  bool _otpSent = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _cardFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _shimmerAnim = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    _phoneController.dispose();
    for (final c in _otpControllers) c.dispose();
    for (final f in _otpFocusNodes) f.dispose();
    super.dispose();
  }

  void _sendOtp() async {
    if (_phoneController.text.length < 10) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      _isLoading = false;
      _otpSent = true;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _otpFocusNodes[0].requestFocus();
    });
  }

void _verifyOtp() async {
  setState(() => _isLoading = true);

  await Future.delayed(const Duration(milliseconds: 1500));

  setState(() => _isLoading = false);

  // ✅ Navigate to Navbar Screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const NavbarScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background pattern
          CustomPaint(
            size: Size(size.width, size.height),
            painter: _BgPainter(),
          ),

          // Top gold arc glow
          Positioned(
            top: -100,
            left: size.width / 2 - 180,
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, __) => Transform.scale(
                scale: _pulseAnim.value,
                child: Container(
                  width: 360,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFD4AF37).withOpacity(0.18),
                        const Color(0xFFD4AF37).withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // Logo section
                    AnimatedBuilder(
                      animation: _entranceController,
                      builder: (_, __) => SlideTransition(
                        position: _logoSlide,
                        child: FadeTransition(
                          opacity: _logoFade,
                          child: _buildLogoSection(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 44),

                    // Card section
                    AnimatedBuilder(
                      animation: _entranceController,
                      builder: (_, __) => SlideTransition(
                        position: _cardSlide,
                        child: FadeTransition(
                          opacity: _cardFade,
                          child: _buildLoginCard(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Terms text
                    FadeTransition(
                      opacity: _cardFade,
                      child: const Text(
                        'By continuing, you agree to our Terms of Service\n& Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF444444),
                          fontSize: 11,
                          height: 1.7,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),

                    FadeTransition(
  opacity: _cardFade,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have an account? ",
        style: TextStyle(
          color: Color(0xFF444444),
          fontSize: 11,
          letterSpacing: 0.3,
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterScreen(),
            ),
          );
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(
            color: Color(0xFFD4AF37), // gold accent
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  ),
),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        // Logo with rings
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer dashed ring
            CustomPaint(
              size: const Size(130, 130),
              painter: _DashedRingPainter(),
            ),
            // Inner glow ring
            Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD4AF37).withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            // Logo circle
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF111111),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.25),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Brand name shimmer
        AnimatedBuilder(
          animation: _shimmerAnim,
          builder: (_, __) => ShaderMask(
            shaderCallback: (bounds) {
              final x = _shimmerAnim.value;
              return LinearGradient(
                colors: const [
                  Color(0xFFD4AF37),
                  Color(0xFFF5E27A),
                  Color(0xFFFFFFFF),
                  Color(0xFFF5E27A),
                  Color(0xFFD4AF37),
                ],
                stops: [
                  (x - 0.4).clamp(0.0, 1.0),
                  (x - 0.1).clamp(0.0, 1.0),
                  x.clamp(0.0, 1.0),
                  (x + 0.1).clamp(0.0, 1.0),
                  (x + 0.4).clamp(0.0, 1.0),
                ],
              ).createShader(bounds);
            },
            child: const Text(
              'BRUBLA',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 8,
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Ornament row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _thinLine(),
            _goldDot(),
            _goldDiamond(),
            _goldDot(),
            _thinLine(),
          ],
        ),

        const SizedBox(height: 6),

        const Text(
          'TAILORED TO PERFECTION',
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFF666666),
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF0F0F0F),
        border: Border.all(color: const Color(0xFF1E1E1E), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.06),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card top gold strip
          Container(
            height: 2,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              gradient: const LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0xFFD4AF37),
                  Color(0xFFF5E27A),
                  Color(0xFFD4AF37),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFD4AF37), Color(0xFFF5E27A)],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _otpSent ? 'Verify OTP' : 'Welcome Back',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF0F0F0),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _otpSent
                              ? 'Enter the 6-digit code sent to your number'
                              : 'Sign in to your account',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555555),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Phone field
                _buildPhoneField(),

                // OTP section
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  crossFadeState: _otpSent
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: const SizedBox.shrink(),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildOtpSection(),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Action button
                _buildActionButton(),

                if (_otpSent) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => setState(() => _otpSent = false),
                      child: RichText(
                        text: const TextSpan(
                          text: "Didn't receive the code? ",
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MOBILE NUMBER',
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFF888888),
            letterSpacing: 2.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFF161616),
            border: Border.all(
              color: _otpSent
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFD4AF37).withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Country code
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Color(0xFF222222), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    const Text('🇮🇳', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 6),
                    const Text(
                      '+91',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey.shade700, size: 18),
                  ],
                ),
              ),

              // Phone input
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  enabled: !_otpSent,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: const TextStyle(
                    color: Color(0xFFEEEEEE),
                    fontSize: 16,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: '00000 00000',
                    hintStyle: TextStyle(
                      color: Color(0xFF333333),
                      letterSpacing: 2,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),

              // Check icon when valid
              if (_phoneController.text.length == 10)
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD4AF37).withOpacity(0.15),
                      border: Border.all(
                          color: const Color(0xFFD4AF37), width: 1),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color(0xFFD4AF37),
                      size: 13,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ENTER OTP',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF888888),
                letterSpacing: 2.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFD4AF37).withOpacity(0.08),
                border: Border.all(
                    color: const Color(0xFFD4AF37).withOpacity(0.2)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.timer_outlined,
                      color: Color(0xFFD4AF37), size: 12),
                  SizedBox(width: 4),
                  Text(
                    '00:59',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // OTP boxes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (i) => _buildOtpBox(i)),
        ),
      ],
    );
  }

  Widget _buildOtpBox(int index) {
    final filled = _otpControllers[index].text.isNotEmpty;
    return SizedBox(
      width: 44,
      height: 54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: filled
              ? const Color(0xFFD4AF37).withOpacity(0.08)
              : const Color(0xFF161616),
          border: Border.all(
            color: filled
                ? const Color(0xFFD4AF37).withOpacity(0.7)
                : const Color(0xFF252525),
            width: filled ? 1.5 : 1,
          ),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.15),
                    blurRadius: 10,
                    spreadRadius: 0,
                  )
                ]
              : null,
        ),
        child: TextField(
          controller: _otpControllers[index],
          focusNode: _otpFocusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: filled ? const Color(0xFFD4AF37) : const Color(0xFFEEEEEE),
            letterSpacing: 0,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (val) {
            setState(() {});
            if (val.isNotEmpty && index < 5) {
              _otpFocusNodes[index + 1].requestFocus();
            } else if (val.isEmpty && index > 0) {
              _otpFocusNodes[index - 1].requestFocus();
            }
          },
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    final isPhoneValid = _phoneController.text.length == 10;
    final isOtpFilled =
        _otpControllers.every((c) => c.text.isNotEmpty);
    final isEnabled = _otpSent ? isOtpFilled : isPhoneValid;

    return GestureDetector(
      onTap: isEnabled && !_isLoading
          ? (_otpSent ? _verifyOtp : _sendOtp)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: isEnabled
              ? const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFE8C84A)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isEnabled ? null : const Color(0xFF1A1A1A),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: _isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Color(0xFF1A1A1A),
                    strokeWidth: 2.5,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _otpSent ? 'VERIFY & LOGIN' : 'SEND OTP',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isEnabled
                            ? const Color(0xFF111111)
                            : const Color(0xFF333333),
                        letterSpacing: 3,
                      ),
                    ),
                    if (isEnabled) ...[
                      const SizedBox(width: 10),
                      Icon(
                        _otpSent
                            ? Icons.verified_rounded
                            : Icons.arrow_forward_rounded,
                        color: const Color(0xFF111111),
                        size: 18,
                      ),
                    ]
                  ],
                ),
        ),
      ),
    );
  }

  Widget _goldDot() => Container(
        width: 4,
        height: 4,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
          color: Color(0xFFD4AF37),
          shape: BoxShape.circle,
        ),
      );

  Widget _goldDiamond() => Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: 5,
          height: 5,
          color: const Color(0xFFD4AF37),
        ),
      );

  Widget _thinLine() => Container(
        width: 30,
        height: 0.8,
        color: const Color(0xFFD4AF37).withOpacity(0.5),
      );
}

// Background dot grid
class _BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF181818);
    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.7, paint);
      }
    }

    // Corner accents
    final accent = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.07)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawPath(
        Path()
          ..moveTo(20, 50)
          ..lineTo(20, 20)
          ..lineTo(50, 20),
        accent);
    canvas.drawPath(
        Path()
          ..moveTo(size.width - 50, 20)
          ..lineTo(size.width - 20, 20)
          ..lineTo(size.width - 20, 50),
        accent);
    canvas.drawPath(
        Path()
          ..moveTo(20, size.height - 50)
          ..lineTo(20, size.height - 20)
          ..lineTo(50, size.height - 20),
        accent);
    canvas.drawPath(
        Path()
          ..moveTo(size.width - 50, size.height - 20)
          ..lineTo(size.width - 20, size.height - 20)
          ..lineTo(size.width - 20, size.height - 50),
        accent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// Dashed ring around logo
class _DashedRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.22)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    const dashCount = 32;
    const dashLen = 0.12;
    const gapLen = 0.07;
    final r = size.width / 2 - 1;
    final c = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < dashCount; i++) {
      final start = (i * (dashLen + gapLen)) * math.pi;
      canvas.drawArc(
          Rect.fromCircle(center: c, radius: r), start, dashLen * math.pi,
          false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}