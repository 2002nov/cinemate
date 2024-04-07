import 'package:flutter/material.dart';
import 'package:test/model/profile.dart';
import '../search.dart';

class Bar extends StatefulWidget {
  final Map<String, dynamic> info;
  final Profile profile;

  const Bar({
    Key? key,
    required this.profile,
    required this.info,
  }) : super(key: key);
  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/logo.jpg', 
        height: 80,
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(profile: widget.profile, info: widget.info),
              ),
            );
          },
        )
      ],
    );
  }
}
