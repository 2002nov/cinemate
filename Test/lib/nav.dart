import 'package:flutter/material.dart';
import 'search.dart';

class Bar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/logo.jpg', 
        height: 80,
      ),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          },
        )
      ],
    );
  }
}
