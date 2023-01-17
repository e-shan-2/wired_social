import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class PickerMehthod {

  UploadTask? _uploadTask;

  Future<String?> imageFromGallery(BuildContext context) async {
 
    FilePickerResult? _result = await FilePicker.platform.pickFiles();
    
    if (_result != null) {
      File file = File(_result.files.first.path!);
      String fileName = _result.files.first.name;

      final ref = FirebaseStorage.instance.ref('images/$fileName');
      _uploadTask = ref.putFile(file);
      final snaphot = await _uploadTask!.whenComplete(() => {});


      final urlDownload = await snaphot.ref.getDownloadURL();
    
     


     


      return urlDownload;
    }
    
    return null;
  }

  Future<String?> pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      File file = File(result.files.first.path!);

      String fileName = result.files.first.name;
      final ref = FirebaseStorage.instance.ref('wiredsocial/file/$fileName');
      _uploadTask = ref.putFile(file);
      final snaphot = await _uploadTask!.whenComplete(() => {});
      final urlDownload = await snaphot.ref.getDownloadURL();

      return urlDownload;
    }
    return null;
  }
}

// File _imageFileGallery = File(_file.path);
//       final path = 'wiredsocial/images${_file}';
//       print(
//           "$path#####################################################################");
//       final ref = FirebaseStorage.instance.ref().child(path);
//       print("$ref f00000000000000000000000000000");

//       _uploadTask = ref.putFile(_imageFileGallery);
//       print("$_uploadTask 111111111111111111111111111111111111");
//       final snaphot = await _uploadTask!.whenComplete(() => {});
//       final urlDownload = await snaphot.ref.getDownloadURL();
