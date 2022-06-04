import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/views/pages/labPage/widgets/backgrounds.dart';
import 'package:bienaventurados/src/views/pages/labPage/widgets/bases.dart';
import 'package:bienaventurados/src/views/pages/labPage/widgets/details.dart';
import 'package:bienaventurados/src/views/pages/labPage/widgets/patterns.dart';
import 'package:bienaventurados/src/views/pages/labPage/widgets/stamps.dart';
import 'package:bienaventurados/src/views/pages/labPage/widgets/wings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class LabPage extends StatefulWidget {
  const LabPage({Key? key}) : super(key: key);

  @override
  State<LabPage> createState() => _LabPageState();
}

class _LabPageState extends State<LabPage> with TickerProviderStateMixin {
  final tabs = [BACKGROUND, PATTERN, BASE, WINGS, STAMP, DETAIL];
  int initialIndex = 0;
  bool donwloadPaperplane = false;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    final shareProvider = Provider.of<ShareProvider>(context);

    TabController tabController = TabController(
        initialIndex: initialIndex, vsync: this, length: tabs.length);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              paperplaneProvider.generateUniquePaperplane();
            },
            icon: Icon(Iconsax.shuffle,
                color: Theme.of(context).primaryColorDark,
                size: MediaQuery.of(context).size.width * DIMENSION_ICON),
          ),
          IconButton(
            onPressed: () {
              shareProvider.takeScreenshot = true;
              shareProvider.downloadPaperplane(screenshotController);
            },
            icon: shareProvider.takeScreenshot
                ? Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width * 0.05,
                    width: MediaQuery.of(context).size.width * 0.05,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  )
                : Icon(Iconsax.receive_square,
                    color: Theme.of(context).primaryColorDark,
                    size: MediaQuery.of(context).size.width * DIMENSION_ICON),
          ),
        ],
      ),
      body: Column(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/paperplanes/background/${paperplaneProvider.background}.png',
                ),
                Image.asset(
                  'assets/images/paperplanes/pattern/${paperplaneProvider.pattern}.png',
                ),
                Image.asset(
                  'assets/images/paperplanes/base/${paperplaneProvider.base}.png',
                ),
                Image.asset(
                  'assets/images/paperplanes/wings/${paperplaneProvider.wings}.png',
                ),
                Image.asset(
                  'assets/images/paperplanes/stamp/${paperplaneProvider.stamp}.png',
                ),
                Image.asset(
                  'assets/images/paperplanes/detail/${paperplaneProvider.detail}.png',
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),
          TabBar(
            indicator: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(100),
            ),
            isScrollable: true,
            controller: tabController,
            onTap: (index) {
              setState(() {
                initialIndex = index;
              });
            },
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).primaryColorDark,
            tabs: tabs
                .map(
                  (title) => Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        title.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TabBarView(
                controller: tabController,
                children: [
                  Backgrounds(BACKGROUND),
                  Patterns(PATTERN),
                  Bases(BASE),
                  Wings(WINGS),
                  Stamps(STAMP),
                  Details(DETAIL),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
