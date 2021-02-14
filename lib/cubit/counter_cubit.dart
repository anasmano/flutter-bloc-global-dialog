import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_global_dialog/cubit/cubit.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(msg: ''));

  void showDialog(String msg) {
    emit(CounterState(msg: msg));
  }
}
