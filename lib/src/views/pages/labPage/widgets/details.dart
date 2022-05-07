import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  final String scrollKey;
  const Details(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List details = [
      'detail-01',
      'detail-02',
      'detail-03',
      'detail-04',
      'detail-05',
      'detail-06',
      'detail-07',
    ];
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 30),
      key: PageStorageKey(scrollKey),
      itemCount: details.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          paperplaneProvider.detail = details[index];
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/paperplanes/detail/${details[index]}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
