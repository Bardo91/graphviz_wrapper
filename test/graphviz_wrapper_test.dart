import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphviz_wrapper/graphviz_wrapper.dart';

void main() {
  const MethodChannel channel = MethodChannel('graphviz_wrapper');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GraphvizWrapper.platformVersion, '42');
  });
}
