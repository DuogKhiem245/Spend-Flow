import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageSyncService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(String localIconKey, String userId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final fileName = path.basename(localIconKey);
      final localFile = File('${directory.path}/$fileName');

      if (!localFile.existsSync()) {
        debugPrint("Lỗi: Không tìm thấy file ảnh tại ${localFile.path}");
        return null;
      }

      final storageRef = _storage.ref().child(
        'users/$userId/categories/$fileName',
      );

      await storageRef.putFile(localFile);

      final downloadUrl = await storageRef.getDownloadURL();
      debugPrint("Upload ảnh thành công: $downloadUrl");

      return downloadUrl;
    } catch (e) {
      debugPrint("Lỗi upload ảnh category: $e");
      return null;
    }
  }

  Future<String?> downloadImageToLocal(
    String remoteUrl,
    String fileName,
  ) async {
    try {
      final response = await http.get(Uri.parse(remoteUrl));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final localPath = path.join(directory.path, fileName);

        final file = File(localPath);
        await file.writeAsBytes(response.bodyBytes);

        debugPrint("Đã tải ảnh về: $localPath");
        return fileName; 
      } else {
        debugPrint("Lỗi tải ảnh HTTP: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Lỗi download ảnh: $e");
    }
    return null;
  }
}
