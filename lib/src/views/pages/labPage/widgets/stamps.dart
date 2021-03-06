import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stamps extends StatelessWidget {
  final String scrollKey;
  const Stamps(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List stamps = [
      'stamp-01',
      'stamp-02',
      'stamp-03',
      'stamp-04',
      'stamp-05',
      'stamp-06',
      'stamp-07',
    ];
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 30),
      key: PageStorageKey(scrollKey),
      itemCount: stamps.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          paperplaneProvider.stamp = stamps[index];
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/paperplanes/stamp/${stamps[index]}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
