import '../../constants/strings.dart';
import 'package:dio/dio.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacter() async {
    try {
      Response response = await dio.get("characters");
      return response.data;
    } catch (error) {
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuote(String chareName) async {
    try {
      Response response =
          await dio.get("quote", queryParameters: {"author": chareName});
      return response.data;
    } catch (error) {
      return [];
    }
  }
}
