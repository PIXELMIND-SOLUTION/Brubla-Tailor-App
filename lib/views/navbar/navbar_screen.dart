// import 'package:brubla_tailor/provider/navbar/navbar_provider.dart';
// import 'package:brubla_tailor/views/home/history_screen.dart';
// import 'package:brubla_tailor/views/home/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:brubla_tailor/views/home/home_screen.dart';


// class NavbarScreen extends StatelessWidget {
//   const NavbarScreen({super.key});

//   static const List<Widget> _pages = [
//     HomeScreen(),
//     HistoryScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final navbarProvider = context.watch<BottomNavbarProvider>();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F7),
//       extendBody: true,
//       body: _pages[navbarProvider.currentIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         index: navbarProvider.currentIndex,
//         height: 65.0,
//         backgroundColor: Colors.transparent,
//         color: const Color(0xFF111111),          // Deep black bar
//         buttonBackgroundColor: Colors.white,      // White raised bubble
//         animationCurve: Curves.easeInOut,
//         animationDuration: const Duration(milliseconds: 400),
//         onTap: (index) => navbarProvider.setIndex(index),
//         items: [
//           Icon(
//             Icons.home_rounded,
//             size: 28,
//             color: navbarProvider.currentIndex == 0
//                 ? Colors.black
//                 : Colors.white,
//           ),
//           Icon(
//             Icons.history_rounded,
//             size: 28,
//             color: navbarProvider.currentIndex == 1
//                 ? Colors.black
//                 : Colors.white,
//           ),
//           Icon(
//             Icons.person_rounded,
//             size: 28,
//             color: navbarProvider.currentIndex == 2
//                 ? Colors.black
//                 : Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }





















import 'package:brubla_tailor/provider/navbar/navbar_provider.dart';
import 'package:brubla_tailor/views/home/history_screen.dart';
import 'package:brubla_tailor/views/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brubla_tailor/views/home/home_screen.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  static const List<Widget> _pages = [
    HomeScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navbarProvider = context.watch<BottomNavbarProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBody: true,
      body: _pages[navbarProvider.currentIndex],
      bottomNavigationBar: _ElegantNavBar(
        currentIndex: navbarProvider.currentIndex,
        onTap: navbarProvider.setIndex,
      ),
    );
  }
}

class _ElegantNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _ElegantNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.history_rounded, label: 'History'),
    _NavItem(icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              return _NavBarItem(
                item: _items[index],
                isSelected: currentIndex == index,
                onTap: () => onTap(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    if (widget.isSelected) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(covariant _NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward(from: 0);
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: widget.isSelected
                  ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: widget.isSelected
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    )
                  : const BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Icon(
                      widget.item.icon,
                      size: 24,
                      color: widget.isSelected
                          ? const Color(0xFF111111)
                          : Colors.white.withOpacity(0.55),
                    ),
                  ),
                  if (widget.isSelected) ...[
                    const SizedBox(width: 8),
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Text(
                        widget.item.label,
                        style: const TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}