import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:graphviz_wrapper/graphviz_wrapper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

String sample = """graph {
    a -- b;
    b -- c;
    a -- c;
    d -- c;
    e -- c;
    e -- a;
}""";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  Pointer<Void> ?_graph, _gvc;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();

    GraphvizWrapper.agmemread(sample).then((graph) {
      _graph = graph;
      GraphvizWrapper.gvContext().then((gvc){
        _gvc = gvc;
        GraphvizWrapper.gvLayout(_gvc!, _graph!, "dot").then((value){
          _localPath.then((path) {
            print("Writing to path " +path+"/sm.png");
            GraphvizWrapper.gvRenderFilename(_gvc!, _graph!, "png", path+"/sm.png");
            GraphvizWrapper.gvFreeLayout(_gvc!, _graph!);
            GraphvizWrapper.agclose(_graph!);
          });
        });
      });
    });

  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await GraphvizWrapper.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
