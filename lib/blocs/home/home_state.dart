abstract class HomeState {
  final int value;

  HomeState(this.value);
}

class InitState extends HomeState {
  InitState() : super(0);
}

class UpdateValueState extends HomeState {
  UpdateValueState(super.value);
}
