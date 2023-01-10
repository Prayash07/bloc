import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/constants/enums.dart';
import 'package:bloc_test/logic/cubit/internet_cubit.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit})
      : super(CounterState(
          counterValue: 0,
          wasIncremented: false,
        )) {
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetStreamSubscription = internetCubit.stream.listen((event) {
      if (event is InternetConnected &&
          event.connectionType == ConnectionType.wifi) {
        increment();
      } else if (event is InternetConnected &&
          event.connectionType == ConnectionType.mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(CounterState(
        counterValue: state.counterValue + 1,
        wasIncremented: true,
      ));
  void decrement() => emit(CounterState(
        counterValue: state.counterValue - 1,
        wasIncremented: false,
      ));

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
