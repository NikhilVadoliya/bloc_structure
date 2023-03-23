import 'package:bloc_structure/blocs/global/global_event.dart';
import 'package:bloc_structure/blocs/global/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(InitGlobalState()) {
    on<AddCartItem>((event, emit) {
      int currentCount = state.cartCount;
      emit(UpdatedCartItem(currentCount + 1));
    });
    on<RemoveCartItem>((event, emit) {
      int currentCount = state.cartCount;
      emit(UpdatedCartItem(currentCount - 1));
    });
  }
}
