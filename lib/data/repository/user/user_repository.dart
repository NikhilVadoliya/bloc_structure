import 'package:bloc_structure/data/repository/user/user_local_repository.dart';
import 'package:bloc_structure/data/repository/user/user_remote_repository.dart';

class UserRepository {
  final UserRemoteRepository remoteRepository;
  final UserLocalRepository localRepository;

  const UserRepository(this.remoteRepository, this.localRepository);
}
