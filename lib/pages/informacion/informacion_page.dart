import 'package:flutter/material.dart';

class InformacionPage extends StatelessWidget {
  const InformacionPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: Text(
          'Información'
        ),
        elevation: 0,
      ),
    );
  }
}