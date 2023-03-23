import 'package:bloc_structure/blocs/splash/splash_event.dart';
import 'package:bloc_structure/blocs/splash/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc():super(InitState()) {
    on<SplashEvent>((event, emit) async {
      if (event is LaunchScreen) {
        await Future.delayed(const Duration(seconds: 3));
        emit(NavigateToHome());
      }
    });
  }
}
