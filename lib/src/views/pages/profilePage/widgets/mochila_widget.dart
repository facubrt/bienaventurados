import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MochilaWidget extends StatefulWidget {
  const MochilaWidget({Key? key}) : super(key: key);

  @override
  _MochilaWidgetState createState() => _MochilaWidgetState();
}

class _MochilaWidgetState extends State<MochilaWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mochila',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemWidget() {
    return InkWell(
      onTap: () {
        print('tap');
      },
      child: Stack(alignment: Alignment.center, children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorPalette.primaryDark)),
        ),
        Icon(Iconsax.element_plus),
      ]),
    );
  }
}
