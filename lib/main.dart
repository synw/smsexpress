import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

import 'home.dart';
import 'node.dart';

const key = String.fromEnvironment("KEY");

Future<void> main() async {
  if (key == null) {
    throw Exception("Provide a key");
  }
  runApp(MyApp());
  unawaited(initRcontactNode(key: key));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rcontact',
      home: const HomePage(),
      theme: ThemeData.dark().copyWith(accentColor: Colors.blueGrey[300]),
    );
  }
}
