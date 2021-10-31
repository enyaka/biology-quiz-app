import 'package:enyaka_biology_quiz/repository/question_api_client.dart';
import 'package:enyaka_biology_quiz/service/cloud_firestore_layer.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => QuestionApiClient());
  locator.registerLazySingleton(() => CloudFirestoreLayer());
}
