import 'dart:io';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<String> uploadFile(File file) async {
    String fileName = basename(file.path);
    StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask task = ref.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;

    return await snapshot.ref.getDownloadURL();
  }
}
