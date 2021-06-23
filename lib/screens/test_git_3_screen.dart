import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_global_dialog/cubit/cubit.dart';

class CemScreen extends StatefulWidget {
  CemScreen({
    Key key,
    this.title,
    this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  _CemScreenState createState() => _CemScreenState();
}

class _CemScreenState extends State<CemScreen> {
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
                'Show Dialog From Third Screen',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              onPressed: () {
                BlocProvider.of<CounterCubit>(context).showDialog(
                    'Show Dialog From Third Screen test git lagi vvv');
              },
            ),
          ],
        ),
      ),
    );
  }
}
