import 'dart:async';

import 'package:email_contact_picker/email_contact_picker.dart';
import 'package:email_contact_picker/model/PickedContact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _emailContactPickerPlugin = EmailContactPicker();
  PickedContact? pickedContact;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      pickedContact = await _emailContactPickerPlugin.pickEmail();
      if (!mounted) return;
      setState(() {});
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(
            'Contact : ${pickedContact?.name}\n${pickedContact?.email}',
          ),
        ),
      ),
    );
  }
}
