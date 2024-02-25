import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:test/login.dart';
import 'package:test/users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('${snapshot.error}');
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'CINEMATE',
            // home: users(),
            home: LoginApp(),
          );
        } else {
          // Handle the case when the future is still loading
          return MaterialApp(
            title: 'CINEMATE',
            home: Scaffold(
              appBar: AppBar(
                title: Text('Loading'),
              ),
              body: Center(
                child: CircularProgressIndicator(), // Or any other loading indicator
              ),
            ),
          );
        }
      },
    );
  }
}
