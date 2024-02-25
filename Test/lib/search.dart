import 'package:flutter/material.dart';
import 'package:test/model/profile.dart';
import 'search_result.dart';
import 'component/drawer.dart';

class SearchPage extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const SearchPage({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(profile: widget.profile, info: widget.info),
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
                      MaterialPageRoute(
                          builder: (context) => SecondPage(
                              searchQuery: searchQuery,
                              profile: widget.profile,
                              info: widget.info)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              onChanged: (value) {
                print('Search query: $value');
              },
              onSubmitted: (String value) {
                // This callback is called when the user submits the search query
                String searchQuery = _searchController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondPage(
                          searchQuery: searchQuery,
                          profile: widget.profile,
                          info: widget.info)),
                );
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
