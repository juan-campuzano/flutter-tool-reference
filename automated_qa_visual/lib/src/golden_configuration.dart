import 'package:meta/meta.dart';

import 'golden_font_loader.dart';
import 'local_file_comparator_with_threshold.dart';
import 'package:flutter_test/flutter_test.dart';

const _kGoldenTestsThreshold = 40 / 100;

@visibleForTesting
Future<void> loadConfiguration() async {
  await loadAppFonts();
  await loadMaterialIconFont();
}

void localFileComparator() {
  if (goldenFileComparator is LocalFileComparator) {
    final testUrl = (goldenFileComparator as LocalFileComparator).basedir;

    //TODO: Encontrar la forma de parametrizar la ruta del test
    goldenFileComparator = LocalFileComparatorWithThreshold(
        Uri.parse('$testUrl/bc_btn_test.dart'), _kGoldenTestsThreshold);
  } else {
    throw Exception(
      goldenFileComparator.runtimeType,
    );
  }
}
