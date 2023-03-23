import 'package:bloc_structure/blocs/home/home_event.dart';
import 'package:bloc_structure/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(InitState()) {
    on<HomeEvent>((event, emit) {
      int currentValue = state.value;
      if (event is Increment) {
        emit(UpdateValueState(currentValue += 5));
      } else if (event is Decrement) {
        emit(UpdateValueState(currentValue -= 1));
      }
    });
  }
}
