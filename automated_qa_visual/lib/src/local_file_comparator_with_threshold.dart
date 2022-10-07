import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class LocalFileComparatorWithThreshold extends LocalFileComparator {
  final double threshold;

  LocalFileComparatorWithThreshold(Uri testFile, this.threshold)
      : assert(threshold >= 0 && threshold <= 1),
        super(testFile);

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (!result.passed && result.diffPercent <= threshold) {
      debugPrint(
        'Se encontró una diferencia de ${result.diffPercent * 100}%, pero es '
        'un valor aceptable, dado que el porcentaje de aceptación es de '
        '${threshold * 100}%',
      );

      return true;
    }

    if (!result.passed) {
      final error = await generateFailureOutput(result, golden, basedir);
      throw FlutterError(error);
    }
    return result.passed;
  }
}
