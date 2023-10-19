import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vzadi/core/error/failure.dart';
import 'package:vzadi/features/map/data/data_sources/map_remote_data_source.dart';
import 'package:vzadi/features/map/data/models/final-destination-model.dart';
import 'package:vzadi/features/map/data/models/get_direction_model.dart';
import 'package:vzadi/features/map/data/models/place_suggestations_model.dart';
import 'package:vzadi/features/map/domain/repositories/map_repository.dart';

import '../../../../core/error/Exceptions.dart';

class MapRepositoryImpl implements MapRepository{
  final MapRemoteDataSource mapRemoteDataSource;
  const MapRepositoryImpl({required this.mapRemoteDataSource});
  @override
  Future<Either<Failure, PlaceSuggestionsModel>> getPlacesSuggestions({required String input, required String type, required String components, required String key, required String
  sessiontoken})async {
    try {
      dynamic response = await mapRemoteDataSource.getPlacesSuggestions(input: input, type: type, components: components, key: key, sessiontoken: sessiontoken);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FinalDestinationModel>> getFinalDestination({required String placeId, required String fields, required String key, required String
  sessiontoken})async {
    try {
      dynamic response = await mapRemoteDataSource.getFinalDestination(placeId: placeId, fields: fields, key: key, sessiontoken: sessiontoken);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetDirectionsModel>> getDirections({required LatLng origin, required LatLng destination, required String
  key})async {
    try {
      dynamic response = await mapRemoteDataSource.getDirections(origin: origin, destination: destination, key: key);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}