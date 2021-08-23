import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:newsapp/helper/constants.dart';
import 'package:newsapp/models/news_model.dart';

import 'api_exception.dart';

class ApiService {
  static const BASE_URL = "https://newsapi.org";

  static const apiKey = "bd8d73020f8f4df58786cd799e813223";

  Future<NewsModel> getNews() async {
    var url = BASE_URL + ApiEndUrl.TOP_HEADLINES + AppConstants.PAGE_SIZE;
    var data = await apiCall(url);
    return newsModelFromJson(data);
  }

  Future<NewsModel> getNewsRefresh() async {
    var url = BASE_URL + ApiEndUrl.TOP_HEADLINES_REFERESH;
    var data = await apiCall(url);
    return newsModelFromJson(data);
  }

  Future<NewsModel> getNewsSearchResult(String searchString) async {
    print("inside getNewsSearchResult");
    var url = BASE_URL + ApiEndUrl.SEARCH_NEWS + searchString;
    var data = await apiCall(url);
    return newsModelFromJson(data);
  }

  Future<dynamic> apiCall(String url) async {
    print("Url: " + url);
    try {
      Map<String, String> headers = {'X-Api-Key': apiKey};
      var res = await http.get(Uri.parse(url), headers: headers);
      return returnResponse(res);
    } on SocketException {
      throw AppException('No Internet connection');
    } on FormatException {
      throw AppException("Bad response format");
    }
  }

  static dynamic returnResponse(http.Response response) {
    // print("Response code: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var res = response.body.toString();
        return res;
      case 400:
        throw BadRequestException("Bad request");
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
