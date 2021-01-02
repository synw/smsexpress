import 'package:nodecommander/nodecommander.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';

NodeCommand contactCommand() {
  return NodeCommand.define(
      name: "contacts",
      executor: (NodeCommand cmd) async {
        final ct = <Map<String, dynamic>>[];
        await Contacts.streamContacts(withThumbnails: false).forEach((contact) {
          final c = contact.toMap();
          ct.add(c);
        });
        return cmd.copyWithPayload(<String, dynamic>{"data": ct});
      });
}

NodeCommand namesCommand() {
  return NodeCommand.define(
      name: "names",
      executor: (NodeCommand cmd) async {
        final ct = <String>[];
        await Contacts.streamContacts(withThumbnails: false).forEach((contact) {
          ct.add(contact.displayName);
        });
        return cmd.copyWithPayload(<String, dynamic>{"data": ct});
      });
}

NodeCommand numbersCommand() {
  return NodeCommand.define(
      name: "numbers",
      executor: (NodeCommand cmd) async {
        final ct = <Map<String, dynamic>>[];
        await Contacts.streamContacts(withThumbnails: false).forEach((contact) {
          final phones = <dynamic>[];
          contact.phones.forEach((p) {
            phones.add(p.value);
          });
          ct.add(<String, dynamic>{
            "name": contact.displayName,
            "numbers": phones
          });
        });
        return cmd.copyWithPayload(<String, dynamic>{"data": ct});
      });
}

NodeCommand smsCommand() {
  return NodeCommand.define(
      name: "sms",
      executor: (NodeCommand cmd) async {
        var ok = false;
        final nameArg = cmd.arguments[0].toString().replaceAll("_", " ");
        final msgArg = cmd.arguments.sublist(1).join(" ");
        await Contacts.streamContacts(withThumbnails: false, query: nameArg)
            .forEach((contact) async {
          final p = contact.phones[0].value;
          await sendSMS(message: msgArg, recipients: <String>[p]);
          ok = true;
        });
        if (!ok) {
          return cmd.copyWithError("Unknown recipient");
        }
        return cmd;
      });
}
