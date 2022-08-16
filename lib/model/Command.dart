import 'dart:convert';

import 'package:fbb_reg_ticket/model/Badge.dart';
import 'package:fbb_reg_ticket/model/command_camp.dart';
import 'package:http/http.dart';

// TODO MIOVA
class Command {
  String id;
  String status;
  Badge? badge;
  List<CommandCamp>? commandCamps;

  Command(
      {required this.id, required this.status, this.badge, this.commandCamps});

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      id: json['id'],
      status: json['status'],
      badge: Badge.fromJson(json['badge']),
      // commandCamps: List<CommandCamp>.from(json['commandCamps']),
      commandCamps: json['commandCamps']
          .map<CommandCamp>((jsonCC) => CommandCamp.fromJson(jsonCC))
          .toList(),
    );
  }

  static Future<Command?> fetchCommand(Client client, String commandId) async {
    print('commandId $commandId');
    try {
      final response = await client.get(
          Uri.parse('http://192.168.43.152:8000/v2api/commands/$commandId'));
      return Command.fromJson(jsonDecode(response.body));
    } catch (e) {
      return null;
    }
  }
}
