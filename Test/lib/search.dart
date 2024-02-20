import 'package:flutter/material.dart';
import 'search_result.dart';
import 'drawer.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            print('arrow back button pressed');
            Navigator.of(context).pop();
          },
        ),
        title: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search your night',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'EncodeSansCondensed',
                  fontSize: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    String searchQuery = _searchController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage(searchQuery)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              onChanged: (value) {
                print('Search query: $value');
              },
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
