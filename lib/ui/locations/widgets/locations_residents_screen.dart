import 'package:app/domain/models/resident.dart';
import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:app/ui/locations/view_models/locations_view_model.dart';
import 'package:app/ui/locations/widgets/residents_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationsResidentsScreen extends StatelessWidget {
  const LocationsResidentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        foregroundColor: AppColors.secondary,
        title: Image.asset('assets/images/residents.png', width: 150),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Consumer<LocationsViewModel>(
        builder: (_, viewModel, child) {
          final residents = viewModel.locations[viewModel.idReference]['residents'];
          if (residents.isEmpty) {
            return Center(
              child: Text('No residents found', style: TextStyle(fontSize: 20, color: AppColors.secondary)),
            );
          }
          return ListView.builder(
            itemCount: residents.length,
            itemBuilder: (_, index) {
              return ResidentsCard(resident: Resident.fromMap(residents[index]));
            },
          );
        },
      ),
    );
  }
}
