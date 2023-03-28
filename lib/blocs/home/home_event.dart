abstract class HomeEvent {}

class GetUserData extends HomeEvent {}

class LastUpdatedRecodeDate extends HomeEvent {}

class AddLastUpdatedRecodeDate extends HomeEvent {
  final int timeStamp;

  AddLastUpdatedRecodeDate(this.timeStamp);
}
