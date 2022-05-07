import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wings extends StatelessWidget {
  final String scrollKey;
  const Wings(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List wings = [
      'wings-01',
      'wings-02',
      'wings-03',
      'wings-04',
      'wings-05',
      'wings-06',
    ];
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 30),
      key: PageStorageKey(scrollKey),
      itemCount: wings.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          paperplaneProvider.wings = wings[index];
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/paperplanes/wings/${wings[index]}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
