import 'package:flutter/material.dart';
import 'package:flutter_news/RssService.dart';
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatelessWidget {
  final String source;
  NewsView({this.source});

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: AppBar(
        title: Text(""),
    automaticallyImplyLeading: true,
    ),
    body: FutureBuilder<RssFeed>(
      future: RssService(source).getFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  ListView.builder(
              itemCount: snapshot.data.items.length,
              itemBuilder: (BuildContext context, int position) {
                final item = snapshot.data.items.elementAt(position);
                return Center(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new ListTile(
                            title: Text(item.title),
                            subtitle: Text(item.description),
                          ),
                          ButtonTheme.bar( // make buttons use the appropriate styles for cards
                            child: ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text('FULL STORY'),
                                  onPressed: () {
                                    _launchURL(item.link);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator());
        }
    )
      );
  }
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

