import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/helper/services/api_services.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/ui/widgets/news_listtile.dart';

class NewsSearchScreen extends StatefulWidget {
  const NewsSearchScreen({Key? key}) : super(key: key);

  @override
  _NewsSearchScreenState createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  TextEditingController _controller = TextEditingController();
  ApiService client = ApiService();
  late StreamController _streamController;
  late Stream _stream;
  bool isShowSearchIcon = false;
  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  _search() async {
    print("inside 0");
    if (_controller.text == null || _controller.text.length == 0) {
      print("inside 1");
      _streamController.add(null);
      return;
    }
    print("inside 2");
    _streamController.add("waiting");
    print("inside 3");
    var data = await client.getNewsSearchResult(_controller.text.trim());
    print("inside 4");
    _streamController.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.red,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextField(
          autofocus: true,
          controller: _controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (val) {
            _search();
          },
          onChanged: (val) {
            if (val.length > 0) {
              setState(() {
                isShowSearchIcon = true;
              });
            } else {
              setState(() {
                isShowSearchIcon = false;
              });
            }
            ;
          },
          decoration: InputDecoration(
            hintText: "Search News",
            border: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
        actions: [
          isShowSearchIcon
              ? IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _search();
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
      body: StreamBuilder(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //let's check if we got a response or not
            print(snapshot.data);
            if (snapshot.data == null) {
              return Center(
                child: Text("Enter a search word"),
              );
            }
            if (snapshot.data == "waiting") {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Article> articles = snapshot.data?.articles ?? [];
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  newsListTile(articles[index], context),
            );
          }),
    );
  }
}
