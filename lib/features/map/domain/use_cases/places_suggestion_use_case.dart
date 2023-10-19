import 'package:dartz/dartz.dart';
import 'package:vzadi/core/error/failure.dart';
import 'package:vzadi/features/map/data/models/place_suggestations_model.dart';
import 'package:vzadi/features/map/domain/repositories/map_repository.dart';

class PlacesSuggestionsUseCase{
  final MapRepository mapRepository;
  const PlacesSuggestionsUseCase({required this.mapRepository});

  Future<Either<Failure , PlaceSuggestionsModel>> getPlacesSuggestions({
    required String input,
    required String type,
    required String components,
    required String key,
    required String sessiontoken,
  })async{
    return await mapRepository.getPlacesSuggestions(input: input, type: type, components: components, key: key, sessiontoken: sessiontoken);
  }

}