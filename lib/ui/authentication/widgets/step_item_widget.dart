import 'package:flutter/material.dart';

class StepItemWidget extends StatelessWidget {
  final int number;
  final String title;
  final String? subtitle;

  const StepItemWidget({required this.number, required this.title, this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha:  0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(number.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(subtitle!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
