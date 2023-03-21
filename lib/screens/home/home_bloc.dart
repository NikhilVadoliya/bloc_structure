import 'package:bloc_structure/screens/home/home_event.dart';
import 'package:bloc_structure/screens/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitState()) {
    on<HomeEvent>((event, emit) {
      int currentValue = state.value;
      if (event is Increment) {
        emit(UpdateValueState(currentValue += 1));
      } else if (event is Decrement) {
        emit(UpdateValueState(currentValue -= 1));
      }
    });
  }
}
