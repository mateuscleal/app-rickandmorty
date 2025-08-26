import 'package:app/routing/app_routes.dart';
import 'package:app/ui/locations/view_models/locations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/location.dart';
import 'location_card.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationsViewModel>(
      builder: (_, viewModel, child) {

        if (viewModel.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (viewModel.locations.isEmpty) {
          return const Center(
            child: Text('No locations found.', style: TextStyle(color: Colors.white)),
          );
        }

        return Column(
          children: [
            Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: viewModel.locations.length + 1,
                itemBuilder: (context, index) {
                  if (index == viewModel.locations.length) {
                    return SizedBox(height: 90);
                  }
                  final location = Location.fromMap(viewModel.locations[index]);
                  return GestureDetector(
                    onTap: () {
                      viewModel.setReference(int.parse(location.id) - 1);
                      Navigator.of(context).pushNamed(AppRoutes.locationsResidents);
                    },
                    child: LocationCard(location: location),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
