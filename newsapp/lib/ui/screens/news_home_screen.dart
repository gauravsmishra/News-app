import 'package:flutter/material.dart';
import 'package:newsapp/helper/services/api_services.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/ui/screens/news_search_screen.dart';
import 'package:newsapp/ui/widgets/news_listtile.dart';

class NewsHomeScreen extends StatefulWidget {
  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  ApiService client = ApiService();
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App", style: TextStyle(color: Colors.red)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewsSearchScreen()));
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            page = page == 1 ? 2 : 1;
          });
          return client.getNewsRefresh();
        },
        child: FutureBuilder<NewsModel>(
          future: page == 1 ? client.getNews() : client.getNewsRefresh(),
          builder: (BuildContext context, AsyncSnapshot<NewsModel> snapshot) {
            //let's check if we got a response or not
            print(snapshot.data);
            if (snapshot.hasData) {
              List<Article> articles = snapshot.data?.articles ?? [];
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) =>
                    newsListTile(articles[index], context),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
