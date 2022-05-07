import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Backgrounds extends StatelessWidget {
  final String scrollKey;
  const Backgrounds(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List backgrounds = [
      'background-01',
      'background-02',
      'background-03',
      'background-04',
      'background-05',
      'background-06',
    ];
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 30),
      key: PageStorageKey(scrollKey),
      itemCount: backgrounds.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          paperplaneProvider.background = backgrounds[index];
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/paperplanes/background/${backgrounds[index]}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
