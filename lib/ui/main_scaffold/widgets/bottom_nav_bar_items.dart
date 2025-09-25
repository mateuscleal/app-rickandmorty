import 'package:flutter/material.dart';

class BottomNavBarItems extends StatelessWidget {
  const BottomNavBarItems({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.width,
  });

  final double? width;
  final bool isSelected;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      height: 65,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isSelected ? Colors.black : Colors.transparent),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black.withValues(alpha: 0.65), size: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.2, color: Colors.black, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
