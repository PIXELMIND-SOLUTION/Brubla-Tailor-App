import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: const [
          SectionTitle(title: "Today"),
          NotificationTile(
            icon: Icons.check_circle,
            title: "Order Accepted",
            subtitle: "Your tailoring order #1234 has been accepted.",
            time: "2 mins ago",
            isUnread: true,
          ),
          NotificationTile(
            icon: Icons.local_shipping,
            title: "Order Out for Delivery",
            subtitle: "Your dress is on the way.",
            time: "1 hour ago",
            isUnread: true,
          ),

          SizedBox(height: 16),
          SectionTitle(title: "Earlier"),
          NotificationTile(
            icon: Icons.payment,
            title: "Payment Successful",
            subtitle: "You paid ₹1500 for order #1234.",
            time: "Yesterday",
            isUnread: false,
          ),
          NotificationTile(
            icon: Icons.design_services,
            title: "Design Ready",
            subtitle: "Your custom design is ready for review.",
            time: "2 days ago",
            isUnread: false,
          ),
          NotificationTile(
            icon: Icons.cancel,
            title: "Order Cancelled",
            subtitle: "Your order #1220 has been cancelled.",
            time: "3 days ago",
            isUnread: false,
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isUnread ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUnread ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isUnread ? Colors.black : Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isUnread ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isUnread ? Colors.white70 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Text(
            time,
            style: TextStyle(
              color: isUnread ? Colors.white70 : Colors.black45,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}