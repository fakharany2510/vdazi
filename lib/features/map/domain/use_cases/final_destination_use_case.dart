import 'package:dartz/dartz.dart';
import 'package:vzadi/core/error/failure.dart';
import 'package:vzadi/features/map/domain/repositories/map_repository.dart';

import '../../data/models/final-destination-model.dart';

class FinalDestinationUseCase{
  final MapRepository mapRepository;
  const FinalDestinationUseCase({required this.mapRepository});

  Future<Either<Failure ,FinalDestinationModel >> getFinalDestination({
    required String placeId,
    required String fields,
    required String key,
    required String sessiontoken,
  })async{
    return await mapRepository.getFinalDestination(placeId: placeId, fields: fields, key: key, sessiontoken: sessiontoken);
  }

}