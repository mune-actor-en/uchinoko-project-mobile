import 'dart:io';

import 'package:uchinoko_project_mobile/infrastructure/model/post_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/service/fetch_api.dart';

class TimelineRepository {
  final HttpService httpService;

  const TimelineRepository({this.httpService});

  Future<List<PostModel>> fetchPosts() async {
    try {
      final extractedData = await httpService.fetchPosts();
      List<PostModel> posts = [];
      extractedData.forEach((element) {
        posts.add(PostModel.fromMap(element));
      });
      return posts;
    } catch(error) {
      return Future.error(error);
    }
  }


  Future<void> createPost(PostModel post, String jwt) async {
    try {
      final int statusCode = await httpService.createPost(post, jwt);
      if (statusCode == HttpStatus.created){
        print('A post is created.');
        return;
      } else {
        return Future.error('err');
      }
    } catch(error) {
      return Future.error(error);
    }
  }
}