import 'package:bloc_structure/data/model/user.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class UserListState extends HomeState {
  const UserListState() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Ideal extends UserListState {
  const Ideal() : super();

  @override
  List<Object?> get props => [];
}

class Loading extends UserListState {
  @override
  List<Object?> get props => [];
}

class GetUser extends UserListState {
  final List<User> user;

  const GetUser(this.user);

  @override
  List<Object?> get props => [user];
}

class Error extends UserListState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}

class RefreshData extends HomeState {
  @override
  List<Object?> get props => [];
}

class LastUpdateDataState extends HomeState {
  const LastUpdateDataState() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetLastUpdatedRecodeDate extends LastUpdateDataState {
  final int timestamp;

  const GetLastUpdatedRecodeDate(this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

class LoadingForLastUpdatedRecodeDate extends LastUpdateDataState {
  @override
  List<Object?> get props => [];
}
