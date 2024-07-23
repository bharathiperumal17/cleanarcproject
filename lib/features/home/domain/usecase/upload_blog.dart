import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:cleanarcproject/core/error/failures.dart';
import 'package:cleanarcproject/core/usecase/usecase.dart';
import 'package:cleanarcproject/features/home/domain/entity/blog_entity.dart';
import 'package:cleanarcproject/features/home/domain/repository/blog_rep_do.dart';

class UploadBlogUsecase implements UseCase<Blog, UploadBlogParams> {
  final BlogRepositry blogRepositry;

  UploadBlogUsecase({required this.blogRepositry});

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepositry.uploadBlog(
      image: params.file,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String content;
  final String title;
  final File file;
  final List<String> topics;

  UploadBlogParams({
    required this.posterId,
    required this.file,
    required this.content,
    required this.title,
    required this.topics,
  });
}
