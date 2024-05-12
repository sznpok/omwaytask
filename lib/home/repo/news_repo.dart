import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:omwaytech/utils/api.dart';
import 'package:omwaytech/utils/om_ways_repo.dart';
import 'package:omwaytech/utils/request_enum.dart';

import '../model/news_model.dart';

class NewsRepo {
  OmWaysRepo omWaysRepo = OmWaysRepo(Client());

  Future<List<NewsModel>> getNews() async {
    final repo = await omWaysRepo.request(
        requestType: RequestEnum.get, url: Api.newsApi);

    try {
      if (repo.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(repo.body);
        return jsonData[0]
            .map<NewsModel>((item) => NewsModel.fromJson(item))
            .toList();
      } else {
        throw Exception("Failed News");
      }
    } catch (e) {
      throw Exception("News Fetching Error $e");
    }
  }
}
