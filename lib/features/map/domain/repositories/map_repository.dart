import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vzadi/core/error/failure.dart';
import 'package:vzadi/features/map/data/models/final-destination-model.dart';
import 'package:vzadi/features/map/data/models/get_direction_model.dart';
import 'package:vzadi/features/map/data/models/place_suggestations_model.dart';

abstract class MapRepository{
  ///place suggestion
  Future<Either<Failure , PlaceSuggestionsModel>> getPlacesSuggestions({
    required String input,
    required String type,
    required String components,
    required String key,
    required String sessiontoken,
});

  ///final destination
  Future<Either<Failure ,FinalDestinationModel>> getFinalDestination({
    required String placeId,
    required String fields,
    required String key,
    required String sessiontoken,
  });

  ///directions
  Future<Either<Failure ,GetDirectionsModel>> getDirections({
    required LatLng origin,
    required LatLng destination,
    required String key,
  });
}