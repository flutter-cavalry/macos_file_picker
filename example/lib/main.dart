import 'package:flutter/material.dart';
import 'dart:async';

import 'package:macos_file_picker/macos_file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _output = '';
  final _macosFilePickerPlugin = MacosFilePicker();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            OutlinedButton(
                onPressed: () => _pick(false, false),
                child: const Text('File')),
            OutlinedButton(
                onPressed: () => _pick(true, false),
                child: const Text('Multiple files')),
            OutlinedButton(
                onPressed: () => _pick(false, true),
                child: const Text('Folder')),
            Text(_output)
          ],
        ),
      ),
    );
  }

  Future<void> _pick(bool allowsMultiple, bool folder) async {
    var res = await _macosFilePickerPlugin.pick(
        allowsMultiple: allowsMultiple, folder: folder);
    setState(() {
      _output = res == null ? 'Cancelled' : res.toString();
    });
  }
}
