import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'dart:io';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key, required this.title});

  final String title;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // Logic ------------------------------------------------------------
  final String filepath = 'favorites.txt';
  final String backText = 'BACK';
  List<String> favorites = [];
  late Future<List<String>> futureJokes;

  Future<List<String>?> readFavorites() async {
    final Directory directory = await path.getApplicationDocumentsDirectory();
    debugPrint('$directory.path');
    File file = File('${directory.path}/$filepath');
    return file.readAsLines();
  }

  @override
  void initState() {
    super.initState();
    readFavorites();
  }

  // UI ------------------------------------------------------------
  // OK, I'd love to use ListView, but instead I have to apply Text.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: FutureBuilder<List<String>?>(
          future: readFavorites(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data![index]);
                },
              );
            } else {
              return const Text('Nothing found');
            }
          },
        ));
  }
}
