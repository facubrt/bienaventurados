import 'package:flutter/material.dart';

class SalirDialog extends StatelessWidget {
  
  const SalirDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
  title: Text('Reset settings?'),
  content: Text('This will reset your device to its default factory settings.'),
  actions: [
    InkWell(
      onTap: () {},
      child: Text('CANCEL'),
    ),
    InkWell(
      onTap: () {},
      child: Text('ACCEPT'),
    ),
  ],
);
  }
}