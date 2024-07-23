import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cleanarcproject/core/error/exceptions.dart';
import 'package:cleanarcproject/features/home/data/model/blog_model.dart';

// abstract class BlogRemoteDataSource {
//   Future<BlogModel> uploadBlog(BlogModel blogModel);
//   Future<List<BlogModel>> getBlogs();
// }

// class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
//   final FirebaseFirestore firestore;
//   final FirebaseStorage storage;

//   BlogRemoteDataSourceImpl({required this.firestore, required this.storage});

//   @override
//   Future<BlogModel> uploadBlog(BlogModel blogModel) async {
//     try {
//       // Upload image to Firebase Storage
//       String fileName = 'image/${DateTime.now().millisecondsSinceEpoch}.png';
//       Reference storageReference = storage.ref().child(fileName);
//       UploadTask uploadTask =
//           storageReference.putFile(File(blogModel.imageUrl));
//       await uploadTask;
//       String downloadUrl = await storageReference.getDownloadURL();

//       // Update the blogModel with the image download URL
//       blogModel = blogModel.copyWith(imageUrl: downloadUrl);
//       print(uploadTask);
//       await firestore
//           .collection('Blog')
//           .doc(blogModel.id)
//           .set(blogModel.toMap());

//       return blogModel;
//     } catch (e) {
//       print(e.toString());
//       throw ServerException(message: e.toString());
//     }
//   }

//   @override
//   Future<List<BlogModel>> getBlogs() async {
//     try {
//       QuerySnapshot snapshot = await firestore.collection('Blog').get();
//       return snapshot.docs
//           .map((doc) => BlogModel.fromMap(doc.data() as Map<String, dynamic>))
//           .toList();
//     } catch (e) {
//       throw ServerException(message: e.toString());
//     }
//   }
// }

abstract class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<List<BlogModel>> getBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  BlogRemoteDataSourceImpl({required this.firestore, required this.storage});

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      // Check if the file exists before uploading
      File imageFile = File(blogModel.imageUrl);
      if (!imageFile.existsSync()) {
        throw Exception("The file does not exist: ${imageFile.path}");
      }

      // Debugging: Print the file path
      print("File path: ${imageFile.path}");

      // Upload image to Firebase Storage
      String fileName = 'image/${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageReference = storage.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask; // Wait for the upload to complete
      print("Image uploaded successfully.");

      // Get the download URL for the uploaded image
      String downloadUrl = await storageReference.getDownloadURL();
      print("Download URL obtained: $downloadUrl");

      // Update the blogModel with the image download URL
      blogModel = blogModel.copyWith(imageUrl: downloadUrl);

      // Save the blog data to Firestore
      await firestore
          .collection('Blog')
          .doc(blogModel.id)
          .set(blogModel.toMap());
      print("Blog data saved to Firestore.");

      return blogModel;
    } catch (e) {
      print("Error occurred: ${e.toString()}"); // Log the error for debugging
      throw ServerException(
          message: e.toString()); // Throw the custom ServerException
    }
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('Blog').get();
      return snapshot.docs
          .map((doc) => BlogModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
