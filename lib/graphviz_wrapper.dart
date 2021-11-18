// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

class GraphvizWrapper {
  static const MethodChannel _channel = MethodChannel('graphviz_wrapper');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static DynamicLibrary _getDynamicLibraryGst() {
    final DynamicLibrary nativeEdgeDetection = Platform.isWindows
        ? DynamicLibrary.open("graphviz_wrapper_plugin.dll")
        : DynamicLibrary.process();
    return nativeEdgeDetection;
  }

  static Future<Pointer<Void>> agmemread(String cmd) async {
    var nativeLib = _getDynamicLibraryGst();
    var fn = nativeLib.lookupFunction<
        Pointer<Void> Function(Pointer<Utf8>),
        Pointer<Void> Function(Pointer<Utf8>)>("native_agmemread");
    return fn(cmd.toNativeUtf8());
  }

  static Future<Pointer<Void>> agnode(Pointer<Void> _graph, String name, int flag) async {
    var nativeLib = _getDynamicLibraryGst();
    var fn = nativeLib.lookupFunction<
        Pointer<Void> Function(Pointer<Void>, Pointer<Utf8>, Int32),
        Pointer<Void> Function(Pointer<Void>, Pointer<Utf8>, int)>("native_agnode");
    return fn(_graph, name.toNativeUtf8(), flag);
  }

  static Future<int> agsafeset(Pointer<Void> _obj, String name, String value, String def) async {
    var nativeLib = _getDynamicLibraryGst();
    var fn = nativeLib.lookupFunction<
        Int32 Function(Pointer<Void>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>),
        int Function(Pointer<Void>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)>("native_agsafeset");
    return fn(_obj, name.toNativeUtf8(), value.toNativeUtf8(), def.toNativeUtf8());
  }

  static Future<Pointer<Void>> gvContext() async {
    var nativeLib = _getDynamicLibraryGst();
    var fn = nativeLib.lookupFunction<
        Pointer<Void> Function(),
        Pointer<Void> Function()>("native_gvContext");
    return fn();
  }

  static Future<int> gvLayout(Pointer<Void> _gvc, Pointer<Void> _graph, String engine) async {
    var nativeLib = _getDynamicLibraryGst();
    var fn = nativeLib.lookupFunction<
        Int32 Function(Pointer<Void>, Pointer<Void>, Pointer<Utf8>),
        int Function(Pointer<Void>, Pointer<Void>, Pointer<Utf8>)>("native_gvLayout");
    return fn(_gvc, _graph, engine.toNativeUtf8());
  }

  static Future<int> gvRenderFilename(Pointer<Void> _gvc, Pointer<Void> _graph, String format, String filename) async {
    var nativeLib = _getDynamicLibraryGst();
    var fn = nativeLib.lookupFunction<
        Int32 Function(Pointer<Void>, Pointer<Void>, Pointer<Utf8>, Pointer<Utf8>),
        int Function(Pointer<Void>, Pointer<Void>, Pointer<Utf8>, Pointer<Utf8>)>("native_gvRenderFilename");
    return fn(_gvc, _graph, format.toNativeUtf8(), filename.toNativeUtf8());
  }

  static Future<int> gvFreeLayout(Pointer<Void> _gvc, Pointer<Void> _graph) async {
    var nativeLib = _getDynamicLibraryGst();
    var fn = nativeLib.lookupFunction<
        Int32 Function(Pointer<Void>, Pointer<Void>),
        int Function(Pointer<Void>, Pointer<Void>)>("native_gvFreeLayout");
    return fn(_gvc, _graph);
  }

  static Future<int> agclose(Pointer<Void> _graph) async {
    var nativeLib = _getDynamicLibraryGst();
    var fn = nativeLib.lookupFunction<
        Int32 Function(Pointer<Void>),
        int Function(Pointer<Void>)>("native_agclose");
    return fn(_graph);
  }

}
