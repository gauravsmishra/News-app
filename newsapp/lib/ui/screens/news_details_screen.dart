import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/news_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;

  NewsDetailsScreen(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            article.source?.name ?? "",
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
              ),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(child: Text("Loading..")),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              article.title ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    article.source?.name ?? "",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                article.publishedAt != null
                    ? Text(
                        "Published at : ${DateFormat("dd-MM-yyyy").format(article.publishedAt ?? DateTime.now())}")
                    : SizedBox.shrink()
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Author:  ${article.author ?? ""}",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            Text(
              article.description ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
