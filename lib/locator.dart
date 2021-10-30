import 'package:enyaka_biology_quiz/repository/question_api_client.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => QuestionApiClient());
}
