// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'dart:io';
import 'package:convey/features/storage/domain/storage_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageRepo implements StorageRepo {
  final SupabaseClient supabase = Supabase.instance.client;

  /*

  PROFILE PICTURES - upload profile image to Supabase Storage
  
  */ 

  // Mobile Platform
  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) async {
    return await _uploadFile(path, fileName, 'profile-pictures');
  }

  // Web Platform
  @override
  Future<String?> uploadProfileImageWeb(
    Uint8List fileBytes,
    String fileName,
  ) async {
    return await _uploadFileWeb(fileBytes, fileName, 'profile-pictures');
  }

    /*

  POST PICTURES - upload posts to Supabase Storage
  
  */ 

  // Mobile Platform
  @override
  Future<String?> uploadPostImageMobile(String path, String fileName) async {
    return await _uploadFile(path, fileName, 'post-pictures');
  }

  // Web Platform
  @override
  Future<String?> uploadPostImageWeb(
    Uint8List fileBytes,
    String fileName,
  ) async {
    return await _uploadFileWeb(fileBytes, fileName, 'post-pictures');
  }

  /*
  
      HELPER METHODS - to upload files to supabase storage
  
  */

  //  mobile platform (files)
  Future<String?> _uploadFile(
    String path,
    String fileName,
    String folder,
  ) async {
    try {
      final filePath = '$folder/$fileName';
      final file = File(path);

      await supabase.storage
          .from(folder)
          .upload(filePath, file, fileOptions: const FileOptions(upsert: true));

      return supabase.storage.from(folder).getPublicUrl(filePath);
    } catch (e) {
      print("Upload Mobile failed: $e");
      return null;
    }
  }

  // web platform (bytes)
  Future<String?> _uploadFileWeb(
    Uint8List fileBytes,
    String fileName,
    String folder,
  ) async {
    try {
      final filePath = '$folder/$fileName';

      await supabase.storage
          .from(folder)
          .uploadBinary(
            filePath,
            fileBytes,
            fileOptions: const FileOptions(upsert: true),
          );

      return supabase.storage.from(folder).getPublicUrl(filePath);
    } catch (e) {
      print("Upload Web failed: $e");
      return null;
    }
  }
}
