import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nodecommander/nodecommander.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi/wifi.dart';

import 'commands.dart';

Future<void> initRcontactNode(
    {@required String key, String name = "smsexpress"}) async {
  await Permission.contacts.request();
  final host = await Wifi.ip;
  final node = SoldierNode(
      key: key,
      name: name,
      commands: <NodeCommand>[
        contactCommand(),
        namesCommand(),
        numbersCommand(),
        smsCommand()
      ],
      host: host,
      verbose: true);
  //node.commands[0].info();
  // initialize the node
  await node.init();
  // print some info about the node
  node.info();
  // idle
  await Completer<void>().future;
}
