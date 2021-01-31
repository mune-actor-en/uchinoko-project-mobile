import 'package:flutter/material.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/post_model.dart';

class TimelineState {
  final bool isLoading;
  final List<PostModel> posts;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const TimelineState({
    @required this.isLoading,
    @required this.posts,
  });

  TimelineState copyWith({
    bool isLoading,
    List<PostModel> posts,
  }) {
    if ((isLoading == null || identical(isLoading, this.isLoading)) &&
        (posts == null || identical(posts, this.posts))) {
      return this;
    }

    return new TimelineState(
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
    );
  }

  @override
  String toString() {
    return 'TimelineState{isLoading: $isLoading, posts: $posts}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimelineState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          posts == other.posts);

  @override
  int get hashCode => isLoading.hashCode ^ posts.hashCode;

  factory TimelineState.fromMap(Map<String, dynamic> map) {
    return new TimelineState(
      isLoading: map['isLoading'] as bool,
      posts: map['posts'] as List<PostModel>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'isLoading': this.isLoading,
      'posts': this.posts,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}