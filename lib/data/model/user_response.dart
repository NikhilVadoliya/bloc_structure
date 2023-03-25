import 'package:bloc_structure/data/model/user.dart';

class UserResponse {
  late final List<User> results;

  UserResponse.fromJson(List<dynamic> list) {
    results = list.map((e) => User.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['results'] = results.map((e) => e.toJson()).toList();
    return data;
  }
}
