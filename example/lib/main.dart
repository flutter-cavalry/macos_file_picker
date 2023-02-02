import 'package:flutter/material.dart';
import 'dart:async';

import 'package:macos_file_picker/macos_file_picker.dart';
import 'package:macos_file_picker/macos_file_picker_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _macosFilePickerPlugin = MacosFilePicker();
  var _mode = MacosFilePickerMode.file;
  var _allowsMultiple = false;
  var _output = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DropdownButton<MacosFilePickerMode>(
                value: _mode,
                onChanged: (MacosFilePickerMode? newValue) {
                  if (newValue == null) {
                    return;
                  }
                  setState(() {
                    _mode = newValue;
                  });
                },
                items: MacosFilePickerMode.values
                    .map((MacosFilePickerMode classType) {
                  return DropdownMenuItem<MacosFilePickerMode>(
                      value: classType, child: Text(classType.toString()));
                }).toList(),
              ),
              _sep(),
              CheckboxListTile(
                title: const Text('Allows multiple'),
                value: _allowsMultiple,
                onChanged: (bool? value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _allowsMultiple = value;
                  });
                },
              ),
              _sep(),
              OutlinedButton(
                  onPressed: _pick, child: const Text('Open dialog')),
              _sep(),
              Text(_output)
            ],
          ),
        ),
      ),
    );
  }

  Widget _sep() {
    return const SizedBox(
      height: 10,
    );
  }

  Future<void> _pick() async {
    var result = await _macosFilePickerPlugin.pick(_mode,
        allowsMultiple: _allowsMultiple);
    setState(() {
      _output = result == null ? 'Cancelled' : result.toString();
    });
  }
}
