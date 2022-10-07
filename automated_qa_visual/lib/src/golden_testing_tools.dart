import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import '../bc_golden_test.dart';

const Size _defaultSize = Size(800, 600);

/// Typedef for wrapping a widget with one or more other widgets
typedef WidgetWrapper = Widget Function(Widget);

extension BcTestingTools on WidgetTester {
  Future<void> bcPumpWidgetBuilder(
    Widget widget, {
    Size surfaceSize = _defaultSize,
    double textScaleSize = 1.0,
  }) async {
    await _pumpWidget(this, widget, surfaceSize, textScaleSize);
  }
}

Future<void> _pumpWidget(
  WidgetTester tester,
  Widget widget,
  Size surfaceSize,
  double textScaleFactor,
) async {
  tester.pumpWidget(AppWidgetBaseTest(widget: widget));
}

bool _inGoldenTest = false;

/// ## bcGoldenTest
/// Function to call the golden test, it replaces the testWigets. This functions
/// are tagged with 'golden'.
///
/// * [description] A brief description of the test,
/// * [test] The test itself,
/// * [shouldUseRealShadows] Whether to render shadows or not,
/// * [targetPlatform] Target platform to run the test.
@isTest
void bcGoldenTest(
  String description,
  Future<void> Function(WidgetTester) test, {
  bool shouldUseRealShadows = false,
  TargetPlatform targetPlatform = TargetPlatform.iOS,
}) {
  testWidgets(
    description,
    (widgetTester) async {
      body() async {
        _inGoldenTest = true;
        final initialDebugDisableShadowsValue = debugDisableShadows;
        debugDefaultTargetPlatformOverride = targetPlatform;
        debugDisableShadows = !shouldUseRealShadows;
        try {
          await test(widgetTester);
        } finally {
          debugDisableShadows = initialDebugDisableShadowsValue;
          debugDefaultTargetPlatformOverride = null;
          _inGoldenTest = false;
        }
      }

      await body();
    },
    tags: ['golden'],
  );
}
