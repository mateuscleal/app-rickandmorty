import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:app/ui/locations/widgets/residents_card.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/location.dart';

class LocationsResidentsScreen extends StatelessWidget {
  const LocationsResidentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationModel location = ModalRoute.of(context)!.settings.arguments as LocationModel;
    final residents = location.residents;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        foregroundColor: AppColors.secondary,
        title: Image.asset('assets/images/residents.png', width: 150),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: residents.isEmpty
          ? Center(
              child: Text('No residents found', style: TextStyle(fontSize: 20, color: AppColors.secondary)),
            )
          : ListView.builder(
              itemCount: residents.length,
              itemBuilder: (_, index) {
                return ResidentsCard(resident: residents[index]);
              },
            ),
    );
  }
}
