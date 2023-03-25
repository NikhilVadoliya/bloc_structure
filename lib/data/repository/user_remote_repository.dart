import 'package:bloc_structure/core/app_string.dart';
import 'package:bloc_structure/data/model/user.dart';
import 'package:bloc_structure/data/model/user_response.dart';
import 'package:bloc_structure/data/remote/api_provider.dart';
import 'package:dio/dio.dart';

class UserRemoteRepository {
  final BaseApiProvider baseApiProvider;

  UserRemoteRepository(this.baseApiProvider);

  Future<List<User>> getUserFromRemote() async {
    Response response = await baseApiProvider.getMethod('?results=10');
    if (response.statusCode == 200) {
      return Future.value(UserResponse.fromJson(response.data['results']).results);
    } else {
      throw Exception(AppString.somethingWentWrong);
    }
  }
}