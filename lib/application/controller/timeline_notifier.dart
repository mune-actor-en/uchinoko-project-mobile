import 'package:flutter_riverpod/all.dart';
import 'package:uchinoko_project_mobile/application/state/timeline_state.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/post_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/timeline_repository.dart';

class TimelineNotifier extends StateNotifier<TimelineState> {
  final TimelineRepository timelineRepository;

  TimelineNotifier({this.timelineRepository}) : super(_initState);

  static const TimelineState _initState = TimelineState(
    isLoading: false,
    posts: [],
  );

  Future<void> fetchPosts() async {
    state = state.copyWith(isLoading: true);
    final List<PostModel> posts = await timelineRepository.fetchPosts();
    state = state.copyWith(posts: posts, isLoading: false);
  }

  Future<void> createPost(PostModel post, String jwt) async {
    state = state.copyWith(isLoading: true);
    await timelineRepository.createPost(post, jwt);
    state = state.copyWith(isLoading: false);
  }
}