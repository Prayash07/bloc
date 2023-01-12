import 'package:bloc_test/constants/enums.dart';
import 'package:bloc_test/logic/cubit/counter_cubit.dart';
import 'package:bloc_test/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  final String title;
  Color? color;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobile) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () =>
                    Navigator.pushNamed(context, '/settingscreen')),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.wifi) {
                    return const Text(
                      "wifi",
                      style: TextStyle(color: Colors.greenAccent, fontSize: 24),
                    );
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.mobile) {
                    return const Text(
                      "mobile",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 24),
                    );
                  } else if (state is InternetDisconnected) {
                    return const Text(
                      "Disconnected",
                      style: TextStyle(color: Colors.redAccent, fontSize: 24),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("value was increased"),
                      duration: Duration(milliseconds: 500),
                    ));
                  } else if (state.wasIncremented != true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("value was decreased"),
                      duration: Duration(milliseconds: 500),
                    ));
                  }
                },
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: widget.color,
                onPressed: () {
                  Navigator.of(context).pushNamed('/secondscreen');
                },
                child: const Text("Goto Second Screen"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
