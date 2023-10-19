
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vzadi/core/api/api_consumer.dart';
import 'package:vzadi/core/api/end_points.dart';

import '../models/final-destination-model.dart';
import '../models/get_direction_model.dart';
import '../models/place_suggestations_model.dart';

abstract class MapRemoteDataSource {
  Future<PlaceSuggestionsModel> getPlacesSuggestions({
    required String input,
    required String type,
    required String components,
    required String key,
    required String sessiontoken,
  });

  Future<FinalDestinationModel> getFinalDestination({
  required String placeId,
  required String fields,
  required String key,
  required String sessiontoken,});

  Future<GetDirectionsModel> getDirections({
    required LatLng origin,
    required LatLng destination,
    required String key,
  });
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource{
  final ApiConsumer apiConsumer;
  const MapRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<PlaceSuggestionsModel> getPlacesSuggestions({required String input,
    required String type, required String components, required String key, required String
  sessiontoken})async {
    dynamic response = await apiConsumer.get(EndPoints.getPlacesSuggestionsEndPoint,
    queryParameters: {
      "input":input,
      "type":type,
      "components":components,
      "key":key,
      "sessiontoken":sessiontoken
    });
    PlaceSuggestionsModel placesSuggestions = PlaceSuggestionsModel.fromJson(response);
    return placesSuggestions;
  }

  @override
  Future<FinalDestinationModel> getFinalDestination({required String placeId, required String fields, required String key, required String
  sessiontoken})async {
    dynamic response = await apiConsumer.get(EndPoints.getFinalDestinationEndPoint,
        queryParameters: {
          "place_id":placeId,
          "fields":fields,
          "key":key,
          "sessiontoken":sessiontoken
        });
    FinalDestinationModel finalDestination = FinalDestinationModel.fromJson(response);
    return finalDestination;
  }

  @override
  Future<GetDirectionsModel> getDirections({required LatLng origin, required LatLng destination, required String
  key})async {
    dynamic response = await apiConsumer.get(EndPoints.getDirectionsEndPoint,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          "key":key,
        });
    GetDirectionsModel directions = GetDirectionsModel.fromJson(response);
    return directions;
  }
}

