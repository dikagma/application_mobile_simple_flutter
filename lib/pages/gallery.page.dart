import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GalleryPage extends StatefulWidget {

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String? keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(keyword ?? 'Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(hintText: 'Key word'),
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GalleryData(value)));
                }
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (keyword != null && keyword!.trim().isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GalleryData(keyword!)));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange),
                child: const Text(
                  'Get Data',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryData extends StatefulWidget {
  final String keyWord;
  const GalleryData(this.keyWord);

  @override
  _GalleryDataState createState() => _GalleryDataState();
}

class _GalleryDataState extends State<GalleryData> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];
  dynamic dataGallery;
  int currentPage = 1;
  int pageSize = 10;
  int totalPages = 0;

  Future<void> getData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);

      setState(() {
        dataGallery = jsonData;
        hits.addAll(jsonData['hits']);
        int totalHits = jsonData['totalHits'];
        totalPages = (totalHits / pageSize).ceil();
      });
    } catch (err) {
      print('Error loading data: $err');
    }
  }

  void loadData() {
    final url =
        "https://pixabay.com/api/?key=5832566-81dc7429a63c86e3b707d0429&q=${Uri.encodeComponent(widget.keyWord)}&page=$currentPage&per_page=$pageSize";
    getData(url);
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          currentPage < totalPages) {
        currentPage++;
        loadData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.keyWord} : $currentPage / $totalPages'),
        backgroundColor: Colors.deepOrange,
      ),
      body: dataGallery == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        itemCount: hits.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      hits[index]['tags'] ?? '',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  child: Image.network(
                    hits[index]['previewURL'] ?? '',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 2),
            ],
          );
        },
      ),
    );
  }
}
