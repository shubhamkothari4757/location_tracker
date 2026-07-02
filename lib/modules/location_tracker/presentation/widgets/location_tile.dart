import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location_tracker/modules/location_tracker/domain/entities/location_entity.dart';

class LocationTile extends StatelessWidget {
  final LocationEntity location;
  final int index;

  const LocationTile({required this.location, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final timeFormatted = DateFormat('hh:mm:ss a').format(location.timestamp);
    final dateFormatted = DateFormat('MMM dd, yyyy').format(location.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          // Sequence Badge
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '#$index',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          // Coordinate Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.formattedCoordinates,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(
                      Icons.my_location_rounded,
                      size: 12.0,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      'Accuracy: ±${location.accuracy.toStringAsFixed(1)}m',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          // Time Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                timeFormatted,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                dateFormatted,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
