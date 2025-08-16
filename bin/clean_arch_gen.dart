#!/usr/bin/env dart

// ignore: unused_import
import 'package:clean_arch_gen/clean_arch_gen.dart';
import 'package:clean_arch_gen/src/services/command/command_manager.dart';

void main(List<String> arguments) async {
  CommandManager manager = CommandManager();
  manager.execute(arguments);
}
