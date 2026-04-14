import 'package:brubla_tailor/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _shimmerController;
  late AnimationController _pulseController;

  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;
  late Animation<double> _shimmerAnim;
  late Animation<double> _pulseAnim;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedCategory;
  bool _isLoading = false;
  bool _agreedToTerms = false;

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Tailor', 'icon': Icons.content_cut_rounded},
    {'label': 'Stylist', 'icon': Icons.style_rounded},
    {'label': 'Designer', 'icon': Icons.design_services_rounded},
    {'label': 'Embroiderer', 'icon': Icons.brush_rounded},
    {'label': 'Alterations', 'icon': Icons.compare_arrows_rounded},
    {'label': 'Customer', 'icon': Icons.person_rounded},
  ];

  final Map<String, FocusNode> _focusNodes = {
    'name': FocusNode(),
    'email': FocusNode(),
    'phone': FocusNode(),
  };






  void _showTailorSuccessDialog() {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.75),
    barrierDismissible: false,
    builder: (context) {
      int countdown = 3;
      return StatefulBuilder(
        builder: (context, setDialogState) {
          // Start countdown
          Future.delayed(Duration.zero, () async {
            for (int i = 3; i > 0; i--) {
              await Future.delayed(const Duration(seconds: 1));
              if (context.mounted) setDialogState(() => countdown = i - 1);
            }
            if (context.mounted) {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const NavbarScreen()),
              );
            }
          });

          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 28),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF2A2A2A)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Gold top strip
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20)),
                      gradient: const LinearGradient(colors: [
                        Colors.transparent,
                        Color(0xFFD4AF37),
                        Color(0xFFF5E27A),
                        Color(0xFFD4AF37),
                        Colors.transparent,
                      ]),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                    child: Column(
                      children: [
                        // Icon with badge
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: const Size(84, 84),
                              painter: _DashedRingPainter(),
                            ),
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF1A1A1A),
                                border: Border.all(
                                    color: const Color(0xFFD4AF37)
                                        .withOpacity(0.25)),
                              ),
                              child: const Icon(
                                Icons.content_cut_rounded,
                                color: Color(0xFFD4AF37),
                                size: 28,
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFD4AF37),
                                  border: Border.all(
                                      color: const Color(0xFF111111),
                                      width: 2),
                                ),
                                child: const Icon(Icons.check_rounded,
                                    color: Color(0xFF111111), size: 13),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'WELCOME BACK',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF555555),
                            letterSpacing: 3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Tailor LoggedIn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF0F0F0),
                          ),
                        ),
                        const Text(
                          'Successfully',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Info row
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF161616),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF222222)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFD4AF37)
                                      .withOpacity(0.1),
                                  border: Border.all(
                                      color: const Color(0xFFD4AF37)
                                          .withOpacity(0.3)),
                                ),
                                child: const Icon(
                                    Icons.content_cut_rounded,
                                    color: Color(0xFFD4AF37),
                                    size: 16),
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('Logged in as',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF777777))),
                                  Text('Tailor',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFEEEEEE),
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xFFD4AF37)
                                      .withOpacity(0.12),
                                  border: Border.all(
                                      color: const Color(0xFFD4AF37)
                                          .withOpacity(0.3)),
                                ),
                                child: const Text('ACTIVE',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFFD4AF37),
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1)),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Continue button
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const NavbarScreen()),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              gradient: const LinearGradient(colors: [
                                Color(0xFFD4AF37),
                                Color(0xFFE8C84A),
                              ]),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD4AF37)
                                      .withOpacity(0.3),
                                  blurRadius: 18,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CONTINUE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF111111),
                                    letterSpacing: 2.5,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded,
                                    color: Color(0xFF111111), size: 16),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        Text(
                          'Redirecting in ${countdown}s',
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF333333)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

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
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _cardFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
      ),
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
    ));

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _shimmerAnim = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    for (final node in _focusNodes.values) {
      node.addListener(() => setState(() {}));
    }

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _shimmerController.dispose();
    _pulseController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    for (final n in _focusNodes.values) n.dispose();
    super.dispose();
  }

  // void _submit() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   if (_selectedCategory == null) {
  //     _showSnack('Please select your category');
  //     return;
  //   }
  //   if (!_agreedToTerms) {
  //     _showSnack('Please agree to Terms & Conditions');
  //     return;
  //   }
  //   setState(() => _isLoading = true);
  //   await Future.delayed(const Duration(milliseconds: 2000));
  //   setState(() => _isLoading = false);
  // }



//   void _submit() async {
//   if (!_formKey.currentState!.validate()) return;

//   if (_selectedCategory == null) {
//     _showSnack('Please select your category');
//     return;
//   }

//   if (!_agreedToTerms) {
//     _showSnack('Please agree to Terms & Conditions');
//     return;
//   }

//   setState(() => _isLoading = true);

//   await Future.delayed(const Duration(milliseconds: 2000));

//   setState(() => _isLoading = false);

//   // ✅ Navigate to Navbar Screen
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const NavbarScreen(),
//     ),
//   );
// }




void _submit() async {
  if (!_formKey.currentState!.validate()) return;
  if (_selectedCategory == null) {
    _showSnack('Please select your category');
    return;
  }
  if (!_agreedToTerms) {
    _showSnack('Please agree to Terms & Conditions');
    return;
  }

  setState(() => _isLoading = true);
  await Future.delayed(const Duration(milliseconds: 2000));
  setState(() => _isLoading = false);

  if (_selectedCategory == 'Tailor') {
    _showTailorSuccessDialog();
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NavbarScreen()),
    );
  }
}
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg,
            style: const TextStyle(color: Color(0xFF111111))),
        backgroundColor: const Color(0xFFD4AF37),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
          // Dot grid bg
          CustomPaint(
            size: Size(size.width, size.height),
            painter: _BgPainter(),
          ),

          // Top radial glow
          Positioned(
            top: -80,
            left: size.width / 2 - 160,
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, __) => Transform.scale(
                scale: _pulseAnim.value,
                child: Container(
                  width: 320,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [
                      const Color(0xFFD4AF37).withOpacity(0.15),
                      const Color(0xFFD4AF37).withOpacity(0.04),
                      Colors.transparent,
                    ]),
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 28),

                    // Logo
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

                    const SizedBox(height: 30),

                    // Card
                    AnimatedBuilder(
                      animation: _entranceController,
                      builder: (_, __) => SlideTransition(
                        position: _cardSlide,
                        child: FadeTransition(
                          opacity: _cardFade,
                          child: _buildFormCard(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    FadeTransition(
                      opacity: _cardFade,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                                color: Color(0xFF555555), fontSize: 12),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
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

  // ── Logo ──────────────────────────────────────────────
  Widget _buildLogoSection() {
    return Row(
      children: [
        // Back button
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF111111),
              border: Border.all(
                  color: const Color(0xFF2A2A2A), width: 1),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFD4AF37), size: 16),
          ),
        ),

        const Spacer(),

        // Logo + name
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                    size: const Size(80, 80),
                    painter: _DashedRingPainter()),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF111111),
                    border: Border.all(
                        color: const Color(0xFFD4AF37).withOpacity(0.3),
                        width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withOpacity(0.2),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset('assets/logo.png',
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
          ],
        ),

        const Spacer(),
        const SizedBox(width: 40), // balance
      ],
    );
  }

  // ── Form card ─────────────────────────────────────────
  Widget _buildFormCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF0E0E0E),
        border: Border.all(color: const Color(0xFF1C1C1C), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gold top strip
          Container(
            height: 2,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              gradient: const LinearGradient(colors: [
                Colors.transparent,
                Color(0xFFD4AF37),
                Color(0xFFF5E27A),
                Color(0xFFD4AF37),
                Colors.transparent,
              ]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
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
                          colors: [
                            Color(0xFFD4AF37),
                            Color(0xFFF5E27A)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF0F0F0),
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Join the craft — set up your profile',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Step dots
                _buildStepIndicator(),

                const SizedBox(height: 28),

                // Fields
                _buildField(
                  label: 'FULL NAME',
                  hint: 'John Doe',
                  controller: _nameController,
                  focusNode: _focusNodes['name']!,
                  icon: Icons.person_outline_rounded,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Name is required' : null,
                ),

                const SizedBox(height: 18),

                _buildField(
                  label: 'EMAIL ADDRESS',
                  hint: 'hello@example.com',
                  controller: _emailController,
                  focusNode: _focusNodes['email']!,
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required';
                    if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(v)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                _buildPhoneField(),

                const SizedBox(height: 18),

                // Category dropdown
                _buildCategoryDropdown(),

                const SizedBox(height: 28),

                // Terms
                _buildTermsRow(),

                const SizedBox(height: 26),

                // Submit
                _buildSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Step indicator ────────────────────────────────────
  Widget _buildStepIndicator() {
    return Row(
      children: List.generate(3, (i) {
        final active = i == 0;
        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: active ? 28 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: active
                    ? const Color(0xFFD4AF37)
                    : const Color(0xFF222222),
              ),
            ),
            if (i < 2)
              Container(
                  width: 12,
                  height: 1,
                  color: const Color(0xFF1E1E1E),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4)),
          ],
        );
      }),
    );
  }

  // ── Generic text field ────────────────────────────────
  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final focused = focusNode.hasFocus;
    final filled = controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF888888),
            letterSpacing: 2.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFF141414),
            border: Border.all(
              color: focused
                  ? const Color(0xFFD4AF37).withOpacity(0.6)
                  : filled
                      ? const Color(0xFFD4AF37).withOpacity(0.2)
                      : const Color(0xFF222222),
              width: focused ? 1.5 : 1,
            ),
            boxShadow: focused
                ? [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.08),
                      blurRadius: 14,
                    )
                  ]
                : null,
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 15,
              letterSpacing: 0.3,
            ),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                  color: Color(0xFF303030), fontSize: 14),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 14, right: 10),
                child: Icon(
                  icon,
                  color: focused
                      ? const Color(0xFFD4AF37)
                      : const Color(0xFF3A3A3A),
                  size: 20,
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: filled
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(Icons.check_circle_rounded,
                          color: const Color(0xFFD4AF37).withOpacity(0.7),
                          size: 18),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 16),
              errorStyle: const TextStyle(
                  color: Color(0xFFE57373), fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }

  // ── Phone field ───────────────────────────────────────
  Widget _buildPhoneField() {
    final focused = _focusNodes['phone']!.hasFocus;
    final filled = _phoneController.text.length == 10;

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
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFF141414),
            border: Border.all(
              color: focused
                  ? const Color(0xFFD4AF37).withOpacity(0.6)
                  : filled
                      ? const Color(0xFFD4AF37).withOpacity(0.2)
                      : const Color(0xFF222222),
              width: focused ? 1.5 : 1,
            ),
            boxShadow: focused
                ? [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.08),
                      blurRadius: 14,
                    )
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(
                          color: Color(0xFF222222), width: 1)),
                ),
                child: Row(
                  children: [
                    const Text('🇮🇳',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    const Text(
                      '+91',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey.shade700, size: 16),
                  ],
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  focusNode: _focusNodes['phone'],
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (v) {
                    if (v == null || v.length < 10) {
                      return 'Enter a valid 10-digit number';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    color: Color(0xFFEEEEEE),
                    fontSize: 15,
                    letterSpacing: 1.5,
                  ),
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: '00000 00000',
                    hintStyle: TextStyle(
                        color: Color(0xFF303030),
                        letterSpacing: 2,
                        fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    errorStyle: TextStyle(
                        color: Color(0xFFE57373), fontSize: 11),
                  ),
                ),
              ),
              if (filled)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD4AF37).withOpacity(0.12),
                      border: Border.all(
                          color: const Color(0xFFD4AF37), width: 1),
                    ),
                    child: const Icon(Icons.check,
                        color: Color(0xFFD4AF37), size: 12),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Category dropdown ─────────────────────────────────
  Widget _buildCategoryDropdown() {
    final selected = _selectedCategory != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SELECT CATEGORY',
          style: TextStyle(
            fontSize: 10,
            color: Color(0xFF888888),
            letterSpacing: 2.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFF141414),
            border: Border.all(
              color: selected
                  ? const Color(0xFFD4AF37).withOpacity(0.5)
                  : const Color(0xFF222222),
              width: selected ? 1.5 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.07),
                      blurRadius: 14,
                    )
                  ]
                : null,
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                dropdownColor: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(14),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: AnimatedRotation(
                    turns: selected ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: selected
                          ? const Color(0xFFD4AF37)
                          : const Color(0xFF444444),
                      size: 22,
                    ),
                  ),
                ),
                hint: Row(
                  children: [
                    const SizedBox(width: 4),
                    const Icon(Icons.category_outlined,
                        color: Color(0xFF3A3A3A), size: 20),
                    const SizedBox(width: 12),
                    const Text(
                      'Choose your role',
                      style: TextStyle(
                        color: Color(0xFF303030),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                selectedItemBuilder: (context) => _categories
                    .map(
                      (cat) => Row(
                        children: [
                          const SizedBox(width: 4),
                          Icon(cat['icon'] as IconData,
                              color: const Color(0xFFD4AF37), size: 20),
                          const SizedBox(width: 12),
                          Text(
                            cat['label'] as String,
                            style: const TextStyle(
                              color: Color(0xFFEEEEEE),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
                items: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat['label'];
                  return DropdownMenuItem<String>(
                    value: cat['label'] as String,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? const Color(0xFFD4AF37).withOpacity(0.15)
                                  : const Color(0xFF1E1E1E),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFD4AF37).withOpacity(0.5)
                                    : const Color(0xFF2A2A2A),
                              ),
                            ),
                            child: Icon(
                              cat['icon'] as IconData,
                              size: 18,
                              color: isSelected
                                  ? const Color(0xFFD4AF37)
                                  : const Color(0xFF555555),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            cat['label'] as String,
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xFFD4AF37)
                                  : const Color(0xFFCCCCCC),
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(Icons.check_rounded,
                                color: Color(0xFFD4AF37), size: 16),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) =>
                    setState(() => _selectedCategory = val),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Terms row ─────────────────────────────────────────
  Widget _buildTermsRow() {
    return GestureDetector(
      onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: _agreedToTerms
                  ? const Color(0xFFD4AF37)
                  : const Color(0xFF161616),
              border: Border.all(
                color: _agreedToTerms
                    ? const Color(0xFFD4AF37)
                    : const Color(0xFF2E2E2E),
                width: 1.5,
              ),
              boxShadow: _agreedToTerms
                  ? [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withOpacity(0.3),
                        blurRadius: 8,
                      )
                    ]
                  : null,
            ),
            child: _agreedToTerms
                ? const Icon(Icons.check_rounded,
                    color: Color(0xFF111111), size: 14)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: const TextSpan(
                text: 'I agree to the ',
                style: TextStyle(
                    color: Color(0xFF555555), fontSize: 12),
                children: [
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Submit button ─────────────────────────────────────
  Widget _buildSubmitButton() {
    final allFilled = _nameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _phoneController.text.length == 10 &&
        _selectedCategory != null &&
        _agreedToTerms;

    return GestureDetector(
      onTap: allFilled && !_isLoading ? _submit : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: allFilled
              ? const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFE8C84A)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: allFilled ? null : const Color(0xFF181818),
          boxShadow: allFilled
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.35),
                    blurRadius: 22,
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
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: allFilled
                            ? const Color(0xFF111111)
                            : const Color(0xFF333333),
                        letterSpacing: 3,
                      ),
                    ),
                    if (allFilled) ...[
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF111111),
                        size: 18,
                      ),
                    ]
                  ],
                ),
        ),
      ),
    );
  }
}

// ── Painters ──────────────────────────────────────────────
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

class _DashedRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.2)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    const dashCount = 28;
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