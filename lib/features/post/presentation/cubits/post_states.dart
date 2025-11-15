/* 

  POST  STATES

*/

import '../../domain/entities/post.dart';

abstract class PostState {}

// Initial

class PostsInitial extends PostState {}

// Loading

class PostsLoading extends PostState {}

// Uploading

class PostsUploading extends PostState {}

// Error

class PostsError extends PostState {
  final String message;
  PostsError(this.message);
}

// Loaded

class PostsLoaded extends PostState {
  final List<Post> posts;
  PostsLoaded(this.posts);
}
