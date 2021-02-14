import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_global_dialog/cubit/cubit.dart';
import 'package:flutter_bloc_global_dialog/screens/third_screen.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({
    Key key,
    this.title,
    this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              color: widget.color,
              child: Text(
                'Show Dialog From Second Screen',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              onPressed: () {
                BlocProvider.of<CounterCubit>(context)
                    .showDialog('Show Dialog From Second Screen');
              },
            ),
            MaterialButton(
              color: Colors.lightBlue,
              child: Text(
                'Go to Third Screen',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (conyext) => ThirdScreen(
                        title: "Third Screen", color: Colors.lightBlue)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
