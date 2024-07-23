import 'package:cleanarcproject/features/home/domain/entity/blog_entity.dart';

class BlogModel {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime dateTime;

  BlogModel({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.dateTime,
  });

  // Convert BlogModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'posterId': posterId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'topics': topics,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  // Create BlogModel from Firestore Map
  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'],
      posterId: map['posterId'],
      title: map['title'],
      content: map['content'],
      imageUrl: map['imageUrl'],
      topics: List<String>.from(map['topics']),
      dateTime: DateTime.parse(map['dateTime']),
    );
  }

  // Convert BlogModel to Domain Blog
  Blog toDomain() {
    return Blog(
      id: id,
      posterId: posterId,
      title: title,
      content: content,
      imageUrl: imageUrl,
      topics: topics,
      dateTime: dateTime,
    );
  }

  // CopyWith method to create a new instance with updated values
  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? dateTime,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
