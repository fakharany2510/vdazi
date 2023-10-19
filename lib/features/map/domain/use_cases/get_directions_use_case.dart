import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vzadi/core/error/failure.dart';
import 'package:vzadi/features/map/data/models/get_direction_model.dart';
import 'package:vzadi/features/map/domain/repositories/map_repository.dart';


class GetDirectionsUseCase{
  final MapRepository mapRepository;
  const GetDirectionsUseCase({required this.mapRepository});

  Future<Either<Failure ,GetDirectionsModel >> getDirections({
    required LatLng origin,
    required LatLng destination,
    required String key,
  })async{
    return await mapRepository.getDirections(origin: origin, destination: destination, key: key);
  }

}