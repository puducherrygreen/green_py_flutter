import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../providers/plant_provider.dart';

class ImageHelper {
  static uploadFile(XFile file,
      {Map<String, dynamic> otherData = const {},
      required PlantProvider plantProvider}) async {
    final FirebaseStorage fs = FirebaseStorage.instance;
    Reference ref = fs.ref().child("Plant_Images").child('/${file.name}');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    UploadTask uploadTask;
    uploadTask = ref.putFile(File(file.path), metadata);
    print("image upload started.......................................");
    print("image upload completed.......................................");

    print("image upload started.......................................");
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      if (TaskState.success == taskSnapshot.state) {
        print("image upload completed.......................................");
        print(taskSnapshot.ref.fullPath);
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        print(imageUrl);
        otherData['imageUrl'] = imageUrl;
        await plantProvider.addPlantPhoto(plantData: otherData);
        print("image upload completed.......................................");
      }
    });
  }
}
