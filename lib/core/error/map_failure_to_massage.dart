import '../utils/app_strings.dart';
import 'failure.dart';

String mapFailureToMsg(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return AppStrings.serverFailure;
    case CacheFailure:
      return AppStrings.cacheFailure;

    default:
      return AppStrings.unExpectedFailure;
  }
}