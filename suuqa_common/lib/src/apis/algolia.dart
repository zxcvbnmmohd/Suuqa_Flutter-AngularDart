import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:suuqa_common/src/configs/api_keys.dart';

class Algolia {
  final Client _client = new Client();
  final String _algoliaWriteURL = '.algolia.net';
  final String _algoliaReadURL = '-dsn.algolia.net';
  final Map<String, String> _headers = {
    'X-Algolia-API-Key': APIKeys.algoliaSearchAPIKey,
    'X-Algolia-Application-Id': APIKeys.algoliaAppID,
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Client get client => _client;
  String get algoliaWriteURL => _algoliaWriteURL;
  String get algoliaReadURL => _algoliaReadURL;
  Map<String, String> get headers => _headers;

  create({String productID, String title, Function onSuccess, Function onFailure(String e)}) async {

  }

  Future<List<String>> read({String search}) async {
    String queryURL = 'https://${APIKeys.algoliaAppID}${this.algoliaReadURL}/1/indexes/$search/query';
    Response response = await this.client.get(Uri.parse(queryURL));
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<Map<String, dynamic>> hits = jsonResponse['hits'];
    List<String> productIDs = [];

    hits.forEach((hit) {
      productIDs.add(hit['objectID']);

    });

//    await this.client
//        .get(Uri.parse(queryURL))
//        .then((res) => res.body)
//        .then(json.decode)
//        .then((json) => json['mosque'])
//        .then((list) => list.forEach((m) => products.add(Product().transform(key: '', map: m))));

    return productIDs;
  }

  update() {

  }

  delete() {

  }
}
