import 'package:flutter/material.dart';


class NotFoundPage extends StatefulWidget {
  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          children: [Text("Page not Found ")],
        ),
      ),
    );
  }
}
