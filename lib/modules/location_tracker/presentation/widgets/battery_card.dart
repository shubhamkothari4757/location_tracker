import 'package:flutter/material.dart';
import 'package:location_tracker/core/theme/app_theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BatteryCard extends StatelessWidget {
  final int batteryLevel;

  const BatteryCard({required this.batteryLevel, super.key});

  @override
  Widget build(BuildContext context) {
    final double percent = batteryLevel >= 0 ? batteryLevel / 100.0 : 0.0;

    Color progressColor = Theme.of(context).colorScheme.primary;
    IconData batteryIcon = Icons.battery_full_rounded;
    String statusText = 'Reading channel...';

    if (batteryLevel < 0) {
      progressColor = Theme.of(context).colorScheme.onSurfaceVariant;
      batteryIcon = Icons.battery_unknown_rounded;
      statusText = 'Initializing...';
    } else if (batteryLevel <= 20) {
      progressColor = AppTheme.batteryLow;
      batteryIcon = Icons.battery_alert_rounded;
      statusText = 'Battery Low';
    } else if (batteryLevel <= 50) {
      progressColor = AppTheme.batteryNormal;
      batteryIcon = Icons.battery_3_bar_rounded;
      statusText = 'Normal';
    } else if (batteryLevel <= 80) {
      progressColor = AppTheme.batteryOptimal;
      batteryIcon = Icons.battery_5_bar_rounded;
      statusText = 'Optimal';
    } else {
      progressColor = AppTheme.batteryFull;
      batteryIcon = Icons.battery_full_rounded;
      statusText = 'Battery Full';
    }

    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surfaceContainer,
              Theme.of(
                context,
              ).colorScheme.surfaceContainer.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Device Battery',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    batteryLevel >= 0 ? '$batteryLevel%' : 'Unknown',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(batteryIcon, size: 16.0, color: progressColor),
                      const SizedBox(width: 4.0),
                      Text(
                        statusText,
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: progressColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 8.0,
              percent: percent,
              center: Icon(batteryIcon, size: 28.0, color: progressColor)
                  .animate(target: batteryLevel <= 20 ? 1 : 0)
                  .fade(duration: 500.ms)
                  .scale()
                  .then()
                  .shake(hz: 3),
              progressColor: progressColor,
              backgroundColor: Theme.of(context).colorScheme.outlineVariant,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 1000,
            )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(0.97, 0.97),
              end: const Offset(1.03, 1.03),
              duration: 2000.ms,
              curve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 600.ms).slideX(begin: -0.1, end: 0);
  }
}
