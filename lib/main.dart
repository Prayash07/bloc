// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_test/logic/cubit/counter_cubit.dart';
import 'package:bloc_test/logic/cubit/internet_cubit.dart';
import 'package:bloc_test/presentation/router/app_router.dart';
import 'package:equatable/equatable.dart';

class MyClass extends Equatable {
  final int value;

  MyClass({required this.value});

  @override
  // TODO: implement props
  List<Object?> get props => [value];
}

void main() {
  final a = MyClass(value: 1);
  final b = MyClass(value: 1);
  if (kDebugMode) {
    print("value is equal or not ${a == b}");
  }
  // runApp(MyApp(
  //   connectivity: Connectivity(),
  // ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  const MyApp({
    Key? key,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: AppRoute().onGenerateRoute,
      ),
    );
  }
}
