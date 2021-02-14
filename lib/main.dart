import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_global_dialog/cubit/cubit.dart';
import 'package:flutter_bloc_global_dialog/screens/second_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void showDialogDemo(String msg) {
    final context = _navigatorKey.currentState.overlay.context;
    final dialog = AlertDialog(
      actions: <Widget>[
        FlatButton(
          child: Text('Ok',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.normal)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      content: Text(msg,
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.normal)),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: Connectivity()),
        ),
        BlocProvider<CounterCubit>(
          create: (counterCubitContext) => CounterCubit(),
        ),
      ],
      child: MaterialApp(
          navigatorKey: _navigatorKey,
          home: Scaffold(
            appBar: AppBar(
              title: Text('First Screen'),
            ),
            body: Builder(builder: (context) {
              return MultiBlocListener(
                listeners: [
                  BlocListener<InternetCubit, InternetState>(
                      listener: (context, state) {
                    if (state is InternetConnected &&
                        state.connectionType == ConnectionType.Wifi) {
                      showDialogDemo(
                          'Show Dialog From Connectivity, Connection Type : Wifi');
                    } else if (state is InternetConnected &&
                        state.connectionType == ConnectionType.Mobile) {
                      showDialogDemo(
                          'Show Dialog From Connectivity, Connection Type : Mobile');
                    } else if (state is InternetDisconnected) {
                      showDialogDemo(
                          'Show Dialog From Connectivity, Disconnected');
                    }
                  }),
                  BlocListener<CounterCubit, CounterState>(
                    listener: (context, state) {
                      showDialogDemo(state.msg);
                    },
                  ),
                ],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Colors.blue,
                        child: Text(
                          'Show Dialog From First Screen',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context)
                              .showDialog('Show Dialog From First Screen');
                        },
                      ),
                      MaterialButton(
                        color: Colors.green,
                        child: Text(
                          'Go to Second Screen',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (conyext) => SecondScreen(
                                  title: "Second Screen",
                                  color: Colors.green)));
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          )),
    );
  }
}
