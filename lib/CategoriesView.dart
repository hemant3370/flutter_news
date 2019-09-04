import 'package:flutter/material.dart';
import 'package:flutter_news/NewsList.dart';
import 'package:flutter_news/Sources.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sources = Sources.rssLinks;

    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        children: List.generate(sources.keys.length, (index) {
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewsView(source: sources.values.elementAt(index).values.elementAt(0))));
              },
              child: Column(
                  children: [
                    Text(
                      sources.keys.elementAt(index),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline,
                    ),
                    FittedBox(
                      child: Image.asset(
                          'assets/${sources.keys.elementAt(index)}.png'),
                      fit: BoxFit.scaleDown,
                    )
                  ]
              )
          );
        })
    );
  }
  }