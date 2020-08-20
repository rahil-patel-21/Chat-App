import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techexperiment001/authcontroller.dart';
import 'package:techexperiment001/providers/image_send_provider.dart';
import 'package:techexperiment001/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: ChangeNotifierProvider<ImageSendProvider>(
        create: (context) => ImageSendProvider(),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xFF102027),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: RootPage(),
        ),
      ),
    );
  }
}
