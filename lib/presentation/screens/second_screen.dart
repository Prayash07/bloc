import 'package:bloc_test/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  final String title;
  Color? color;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
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
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  heroTag: "btn2",
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(
                  width: 24,
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  heroTag: "btn1",
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  "/",
                );
              },
              child: const Text("Goto first Screen"),
            )
          ],
        ),
      ),
    );
  }
}
