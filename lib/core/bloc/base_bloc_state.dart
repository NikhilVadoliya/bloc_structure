import 'package:equatable/equatable.dart';

enum BaseStatus { ideal, loading, success, error }

abstract class BaseBlocState<T> extends Equatable {
  final BaseStatus status;
  final T t;
  final String? errorMessage;

  const BaseBlocState(this.status, this.t, this.errorMessage);
}
