import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class RssService {
  String url;
  RssService(String url) {
    this.url = url;
  }
  Future<RssFeed> getFeed() =>
      http.read(url).then((xmlString) => RssFeed.parse(xmlString));
}