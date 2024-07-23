import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:cleanarcproject/core/error/failures.dart';
import 'package:cleanarcproject/features/home/data/datasource/bog_remote_data_source.dart';
import 'package:cleanarcproject/features/home/data/model/blog_model.dart';
import 'package:cleanarcproject/features/home/domain/entity/blog_entity.dart';
import 'package:cleanarcproject/features/home/domain/repository/blog_rep_do.dart';
import 'package:uuid/uuid.dart';

class BlogRepositryImp implements BlogRepositry {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositryImp({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        dateTime: DateTime.now(),
      );

      final result = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(result.toDomain());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
