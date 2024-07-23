part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {}

final class BlogFaliure extends BlogState {
  final String fmessage;
  BlogFaliure({required this.fmessage});
}
