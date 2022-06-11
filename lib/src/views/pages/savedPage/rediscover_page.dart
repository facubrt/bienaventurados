import 'package:bienaventurados/src/models/paperplane_model.dart';
import 'package:bienaventurados/src/views/pages/paperplanePage/paperplane_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RediscoverPage extends StatefulWidget {
  final Paperplane paperplaneSaved;

  const RediscoverPage({
    Key? key,
    required this.paperplaneSaved,
  }) : super(key: key);

  @override
  _RediscoverPageState createState() => _RediscoverPageState();
}

class _RediscoverPageState extends State<RediscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.close_square,
              size: MediaQuery.of(context).size.width * 0.06,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: PaperplanePage(paperplane: widget.paperplaneSaved),
    );
  }
}
