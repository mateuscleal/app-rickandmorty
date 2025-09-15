import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.name,
    required this.status,
    required this.species,
    required this.imagePath,
  });

  final String name;
  final String status;
  final String species;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.white70, spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accent),
                image: DecorationImage(image: NetworkImage(imagePath)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: $name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Status: $status", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("Species: $species", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
