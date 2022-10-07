import 'package:flutter/material.dart';

class AppPageBaseTest extends StatelessWidget {
  final Widget widget;

  const AppPageBaseTest({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget,
    );
  }
}

//TODO: Cargar tema de la app que se está testeando
class AppWidgetBaseTest extends StatelessWidget {
  final Widget widget;

  const AppWidgetBaseTest({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: RepaintBoundary(child: widget),
      ),
    );
  }
}
