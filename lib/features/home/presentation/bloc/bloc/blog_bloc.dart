import 'dart:async';
import 'dart:io';

import 'package:cleanarcproject/features/home/domain/usecase/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase blogUsecase;
  BlogBloc(this.blogUsecase) : super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<BlogUpload>(blogUpload);
  }

  FutureOr<void> blogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await blogUsecase(UploadBlogParams(
        posterId: event.posterId,
        file: event.file,
        content: event.content,
        title: event.title,
        topics: event.topics));
    res.fold((l) => emit(BlogFaliure(fmessage: l.message)),
        (r) => emit(BlogSuccess()));
  }
}
