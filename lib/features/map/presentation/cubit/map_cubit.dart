

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vzadi/features/map/data/models/final-destination-model.dart';
import 'package:vzadi/features/map/data/models/get_direction_model.dart';
import 'package:vzadi/features/map/data/models/place_suggestations_model.dart';
import 'package:vzadi/features/map/domain/use_cases/get_directions_use_case.dart';
import 'package:vzadi/features/map/presentation/cubit/map_state.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/map_failure_to_massage.dart';
import '../../domain/use_cases/final_destination_use_case.dart';
import '../../domain/use_cases/places_suggestion_use_case.dart';

class MapCubit extends Cubit<MapState> {
  final PlacesSuggestionsUseCase placesSuggestionsUseCase;
  final FinalDestinationUseCase finalDestinationUseCase;
  final GetDirectionsUseCase getDirectionsUseCase;
  MapCubit({required this.placesSuggestionsUseCase, required this.getDirectionsUseCase,required this.finalDestinationUseCase}) : super(MapInitial());
  static MapCubit get(context) => BlocProvider.of(context);

  /// places suggestion
  Future<void> getPlacesSuggestions({
    required String input,
    required String type,
    required String components,
    required String key,
    required String sessiontoken,
  })async{
    emit(GetPlacesSuggestionLoading());
    Either<Failure, PlaceSuggestionsModel> response =
    await placesSuggestionsUseCase.getPlacesSuggestions(input: input, type: type, components: components, key: key, sessiontoken: sessiontoken);

    response.fold(
            (failure) =>
            emit(GetPlacesSuggestionError(message: mapFailureToMsg(failure))),
            (PlaceSuggestionsModel placeSuggestionsModel) {
          if(placeSuggestionsModel.status == "OK") {
            emit(GetPlacesSuggestionLoaded(placeSuggestionsModel: placeSuggestionsModel));
          }else{
            emit(GetPlacesSuggestionError(message: placeSuggestionsModel.status));
          }
        });
  }

  ///final destination
  Future<void> getFinalDestination({
    required String placeId,
    required String fields,
    required String key,
    required String sessiontoken,
  })async{
    emit(GetFinalDestinationLoading());
    Either<Failure, FinalDestinationModel> response =
    await finalDestinationUseCase.getFinalDestination(placeId: placeId, fields: fields, key: key, sessiontoken: sessiontoken
    );

    response.fold(
            (failure) =>
            emit(GetFinalDestinationError(message: mapFailureToMsg(failure))),
            (FinalDestinationModel finalDestinationModel) {
          if(finalDestinationModel.status == "OK") {
            emit(GetFinalDestinationLoaded(finalDestinationModel: finalDestinationModel));
          }else{
            emit(GetFinalDestinationError(message: finalDestinationModel.status));
          }
        });
  }


  ///directions
  Future<void> getDirections({
    required LatLng origin,
    required LatLng destination,
    required String key,
  })async{
    emit(GetDirectionsLoading());
    Either<Failure, GetDirectionsModel> response =
    await getDirectionsUseCase.getDirections(origin: origin, destination: destination, key: key);

    response.fold(
            (failure) =>
            emit(GetDirectionsError(message: mapFailureToMsg(failure))),
            (GetDirectionsModel getDirectionsModel) {
            emit(GetDirectionsLoaded(getDirectionsModel: getDirectionsModel));

        });
  }

}
