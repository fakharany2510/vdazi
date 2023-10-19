import 'package:equatable/equatable.dart';
import 'package:vzadi/features/map/data/models/final-destination-model.dart';
import 'package:vzadi/features/map/data/models/get_direction_model.dart';

import '../../data/models/place_suggestations_model.dart';

abstract class MapState extends Equatable{
  const MapState();
  @override
  List<Object?> get props =>[];
}

class MapInitial extends MapState {}

class GetPlacesSuggestionLoading extends MapState {}
class GetPlacesSuggestionLoaded extends MapState {
  final PlaceSuggestionsModel placeSuggestionsModel;
  const GetPlacesSuggestionLoaded({required this.placeSuggestionsModel});
  @override
  List<Object?> get props =>[placeSuggestionsModel];
}
class GetPlacesSuggestionError extends MapState {
  final String message;
  const GetPlacesSuggestionError({required this.message});
  @override
  List<Object?> get props =>[message];
}

class GetFinalDestinationLoading extends MapState {}
class GetFinalDestinationLoaded extends MapState {
  final FinalDestinationModel finalDestinationModel;
  const GetFinalDestinationLoaded({required this.finalDestinationModel});
  @override
  List<Object?> get props =>[finalDestinationModel];
}
class GetFinalDestinationError extends MapState {
  final String message;
  const GetFinalDestinationError({required this.message});
  @override
  List<Object?> get props =>[message];
}

class GetDirectionsLoading extends MapState {}
class GetDirectionsLoaded extends MapState {
  final GetDirectionsModel getDirectionsModel;
  const GetDirectionsLoaded({required this.getDirectionsModel});
  @override
  List<Object?> get props =>[getDirectionsModel];
}
class GetDirectionsError extends MapState {
  final String message;
  const GetDirectionsError({required this.message});
  @override
  List<Object?> get props =>[message];
}