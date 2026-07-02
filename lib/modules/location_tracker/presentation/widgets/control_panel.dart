import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ControlPanel extends StatelessWidget {
  final bool isTracking;
  final String? activeSessionId;
  final VoidCallback onStart;
  final VoidCallback onStop;

  const ControlPanel({
    required this.isTracking,
    required this.activeSessionId,
    required this.onStart,
    required this.onStop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              ).colorScheme.surfaceContainer.withValues(alpha: 0.9),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tracking Controls',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Pulse status indicator
                Row(
                  children: [
                    Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: isTracking
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            shape: BoxShape.circle,
                          ),
                        )
                        .animate(
                          onPlay: (controller) => isTracking
                              ? controller.repeat(reverse: true)
                              : controller.stop(),
                        )
                        .fade(begin: 0.4, end: 1.0, duration: 800.ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.2, 1.2),
                        ),
                    const SizedBox(width: 8.0),
                    Text(
                      isTracking ? 'ACTIVE' : 'IDLE',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isTracking
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            if (isTracking && activeSessionId != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVE SESSION',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      activeSessionId!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 14.0,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          'Interval: 60s • Auto-restart enabled',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fade(duration: 400.ms).slideY(begin: 0.1, end: 0),
              const SizedBox(height: 20.0),
            ],
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isTracking ? null : onStart,
                    icon: const Icon(Icons.play_arrow_rounded, size: 24.0),
                    label: const Text('START'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      disabledBackgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      disabledForegroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isTracking ? onStop : null,
                    icon: const Icon(Icons.stop_rounded, size: 24.0),
                    label: const Text('STOP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      disabledBackgroundColor: Theme.of(
                        context,
                      ).colorScheme.error.withValues(alpha: 0.1),
                      disabledForegroundColor: Theme.of(
                        context,
                      ).colorScheme.error.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 600.ms).slideX(begin: 0.1, end: 0);
  }
}
