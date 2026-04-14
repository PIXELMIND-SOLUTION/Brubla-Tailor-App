// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         // leading: const BackButton(color: Colors.black),
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
          
//         ),
        
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),

//             // ── Profile Info ──
//             Row(
//               children: [
//                 Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 38,
//                       backgroundColor: Colors.grey[200],
//                       backgroundImage: const NetworkImage(
//                         'https://randomuser.me/api/portraits/men/75.jpg',
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: const Icon(Icons.edit, size: 14, color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Narasimha Varma',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '9666317749',
//                       style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),
//             Divider(color: Colors.grey[200], thickness: 1),
//             const SizedBox(height: 16),

//             // ── Quick Action Grid ──
//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 3,
//               children: const [
//                 _ActionButton(label: 'Orders', icon: Icons.receipt_long_outlined),
//                 _ActionButton(label: 'BMI', icon: Icons.monitor_weight_outlined),
//                 _ActionButton(label: 'Help', icon: Icons.help_outline),
//                 _ActionButton(label: 'Coupons', icon: Icons.local_offer_outlined),
//                 _ActionButton(label: 'Address', icon: Icons.location_on_outlined),
//                 _ActionButton(label: 'Wishlist', icon: Icons.favorite_border),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // ── Banner ──
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Stack(
//                 children: [
//                   Image.network(
//                     'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
//                     height: 110,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       height: 110,
//                       color: Colors.grey[100],
//                       child: const Center(
//                         child: Icon(Icons.image_outlined, color: Colors.grey, size: 36),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 110,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.black.withOpacity(0.65),
//                           Colors.transparent,
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 14,
//                     top: 14,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'GRAND',
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.85),
//                             fontSize: 11,
//                             letterSpacing: 2,
//                           ),
//                         ),
//                         const Text(
//                           '— OPENING',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w800,
//                             letterSpacing: 1,
//                           ),
//                         ),
//                         const Text(
//                           'FASHION STORE',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 11,
//                             letterSpacing: 1.5,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: const Text(
//                             'GET IT NOW',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 9,
//                               fontWeight: FontWeight.w700,
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             // ── Account Section ──
//             Text(
//               'Account',
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[500],
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 8),

//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade200),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 children: [
//                   _AccountTile(
//                     icon: Icons.help_outline,
//                     label: 'Need Help?',
//                     onTap: () {},
//                   ),
//                   Divider(height: 1, color: Colors.grey[200]),
//                   _AccountTile(
//                     icon: Icons.phone_outlined,
//                     label: 'Contact Us',
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 12),

//             // ── Logout ──
//             InkWell(
//               onTap: () {},
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade200),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.logout, size: 18, color: Colors.black),
//                         const SizedBox(width: 12),
//                         const Text(
//                           'Logout',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Icon(Icons.chevron_right, color: Colors.grey[400]),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ── Quick Action Button ──
// class _ActionButton extends StatelessWidget {
//   final String label;
//   final IconData icon;

//   const _ActionButton({required this.label, required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: () {},
//       style: OutlinedButton.styleFrom(
//         foregroundColor: Colors.black,
//         side: const BorderSide(color: Colors.black, width: 1.2),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 16),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Account List Tile ──
// class _AccountTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const _AccountTile({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, size: 18, color: Colors.grey[700]),
//                 const SizedBox(width: 12),
//                 Text(
//                   label,
//                   style: const TextStyle(fontSize: 14, color: Colors.black),
//                 ),
//               ],
//             ),
//             Icon(Icons.chevron_right, color: Colors.grey[400]),
//           ],
//         ),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              /// ── Profile Info ──
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: const NetworkImage(
                          'https://randomuser.me/api/portraits/men/75.jpg',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Icon(Icons.edit, size: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Narasimha Varma',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '9666317749',
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Divider(color: Colors.grey[200]),
              const SizedBox(height: 16),

              /// ── Quick Actions ──
              SizedBox(
                height: 180,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    _ActionButton(
                        label: 'Orders',
                        icon: Icons.receipt_long_outlined),
                    _ActionButton(
                        label: 'BMI',
                        icon: Icons.monitor_weight_outlined),
                    _ActionButton(
                        label: 'Help', icon: Icons.help_outline),
                    _ActionButton(
                        label: 'Coupons',
                        icon: Icons.local_offer_outlined),
                    _ActionButton(
                        label: 'Address',
                        icon: Icons.location_on_outlined),
                    _ActionButton(
                        label: 'Wishlist',
                        icon: Icons.favorite_border),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ── Banner ──
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.65),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 14,
                      top: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GRAND',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            '— OPENING',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'FASHION STORE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ── Account Section ──
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _AccountTile(
                      icon: Icons.help_outline,
                      label: 'Need Help?',
                      onTap: () {},
                    ),
                    Divider(height: 1, color: Colors.grey[200]),
                    _AccountTile(
                      icon: Icons.phone_outlined,
                      label: 'Contact Us',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// ── Logout ──
              InkWell(
                onTap: () {
                  // TODO: Logout logic
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.logout, color: Colors.red),
                          SizedBox(width: 12),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

/// ── Quick Action Button ──
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ActionButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black, width: 1.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// ── Account Tile ──
class _AccountTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AccountTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: Colors.grey[700]),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}