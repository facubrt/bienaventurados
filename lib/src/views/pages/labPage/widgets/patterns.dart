import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Patterns extends StatelessWidget {
  final String scrollKey;
  const Patterns(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List patterns = [
      'pattern-01',
      'pattern-02',
      'pattern-03',
      'pattern-04',
      'pattern-05',
      'pattern-06',
    ];
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 30),
      key: PageStorageKey(scrollKey),
      itemCount: patterns.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          paperplaneProvider.pattern = patterns[index];
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/paperplanes/pattern/${patterns[index]}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
