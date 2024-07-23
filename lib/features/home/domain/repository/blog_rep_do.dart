import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:cleanarcproject/core/error/failures.dart';
import 'package:cleanarcproject/features/home/domain/entity/blog_entity.dart';

abstract class BlogRepositry {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
}
