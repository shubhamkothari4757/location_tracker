import 'package:flutter/material.dart';
import 'package:location_tracker/modules/location_tracker/domain/entities/location_entity.dart';
import 'package:location_tracker/modules/location_tracker/presentation/widgets/location_tile.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LocationListView extends StatelessWidget {
  final List<LocationEntity> locations;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const LocationListView({
    required this.locations,
    this.shrinkWrap = false,
    this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_rounded,
              size: 48.0,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ).animate().fade().scale(delay: 100.ms),
            const SizedBox(height: 12.0),
            Text(
              'No location entries found',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    final reversedLocations = locations.reversed.toList();

    return Scrollbar(
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        itemCount: reversedLocations.length,
        itemBuilder: (context, index) {
          final loc = reversedLocations[index];
          final logicalIndex = locations.length - index;

          return LocationTile(location: loc, index: logicalIndex)
              .animate()
              .fade(duration: 300.ms, delay: (index * 50).ms)
              .slideY(begin: 0.1, end: 0);
        },
      ),
    );
  }
}
