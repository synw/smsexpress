import 'package:nodecommander/nodecommander.dart';

NodeCommand createCommand(String name, {void Function(NodeCommand) exec}) {
  return NodeCommand.define(
      name: name,
      executor: null,
      responseProcessor: (NodeCommand cmd) {
        if (exec == null) {
          print(cmd.payload);
        } else {
          exec(cmd);
        }
        return;
      });
}

void main(List<String> args) {
  if (args.isEmpty) {
    print(Tokens.generateKey());
    return;
  }
  final key = args[0];
  final node = CommanderNode(
      key: key,
      name: "rterm_cli",
      commands: <NodeCommand>[
        createCommand("contacts"),
        createCommand("names",
            exec: (NodeCommand cmd) =>
                print((cmd.payload["data"] as List<dynamic>).join(", "))),
        createCommand("numbers", exec: (NodeCommand cmd) {
          (cmd.payload["data"] as List<dynamic>).forEach((dynamic c) {
            final co = c as Map<String, dynamic>;
            print(
                "${co["name"]} : ${(co["numbers"] as List<dynamic>).join(", ")}");
          });
        }),
        createCommand("sms", exec: (NodeCommand cmd) => print("ok"))
      ],
      port: 8085,
      verbose: true);
  // cli
  NodeCommanderCli(node).run();
}
