import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../utils/constants.dart';

Future<void> cacheCatImage(String image) async {
  final tempFile = await DefaultCacheManager().getSingleFile(image);

  final appDir = await getApplicationDocumentsDirectory();
  final fileName = basename(tempFile.path);
  final savedFile = File('${appDir.path}/$fileName');

  if (!await savedFile.exists()) {
    await tempFile.copy(savedFile.path);
  }

  final box = Hive.box<String>(kCatImageBox);
  await box.add(savedFile.path);
}
