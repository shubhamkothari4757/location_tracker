import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:location_tracker/core/error/failure.dart';

class BatteryService {
  static const MethodChannel _channel = MethodChannel('com.outfox.location_tracker/battery');

  /// Fetches the current battery level of the device.
  /// Returns [Right] with battery percentage (0-100) or [Left] with a [Failure].
  Future<Either<Failure, int>> getBatteryLevel() async {
    try {
      final int? result = await _channel.invokeMethod<int>('getBatteryLevel');
      if (result != null) {
        return Right(result);
      } else {
        return const Left(Failure.unknownError('Received null battery percentage from platform'));
      }
    } on PlatformException catch (e) {
      return Left(Failure.unknownError(e.message ?? 'Platform Exception retrieving battery level'));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }
}
