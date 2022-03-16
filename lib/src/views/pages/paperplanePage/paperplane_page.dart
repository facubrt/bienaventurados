import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/data/local/drawer_items.dart';
import 'package:bienaventurados/src/data/local/meses_data.dart';
import 'package:bienaventurados/src/models/avioncito_model.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class PaperplanePage extends StatefulWidget {
  final Avioncito paperplane;

  const PaperplanePage({Key? key, required this.paperplane}) : super(key: key);

  @override
  _PaperplanePageState createState() => _PaperplanePageState();
}

class _PaperplanePageState extends State<PaperplanePage> {
  late double? reflexionHeight;
  late bool reflexionOpen;

  ScreenshotController screenshotController = ScreenshotController();
  bool takingScreen = false;
  bool share = false;
  bool donwloadPaperplane = false;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    reflexionHeight = 0;
    reflexionOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    final shareProvider = Provider.of<ShareProvider>(context);
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! < -7) {
          setState(() {
            reflexionHeight = MediaQuery.of(context).size.height / 4;
            reflexionOpen = true;
          });
        } else if (details.primaryDelta! > 7) {
          setState(() {
            reflexionHeight = 0;
            reflexionOpen = false;
          });
        }
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Screenshot(
                  controller: screenshotController,
                  child: Container(
                    color: Theme.of(context).primaryColorDark,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linearToEaseOut,
                      transformAlignment: Alignment.center,
                      transform: Matrix4.identity()..scale(shareProvider.takeScreenshot ? 0.72 : 1.0, shareProvider.takeScreenshot ? 0.72 : 1.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: shareProvider.takeScreenshot
                            ? Border.all(width: BORDER_WIDTH, color: Theme.of(context).primaryColorDark)
                            : Border.all(width: 0.0, color: Theme.of(context).primaryColor),
                        borderRadius: shareProvider.takeScreenshot ? BorderRadius.circular(BORDER_RADIUS) : BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: paperplaneWidget(),
                      ),
                    ),
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  elevation: 0.0,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Iconsax.close_square,
                        size: MediaQuery.of(context).size.width * DIMENSION_ICON,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              shareProvider.takeScreenshot
                  ? Container(
                      color: ColorPalette.primaryDark.withOpacity(0.9),
                      child: Center(
                        child: Text(
                          PREPARING_PAPERPLANE,
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(fontSize: MediaQuery.of(context).size.width * SCALE_H3, color: ColorPalette.primaryLight),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget paperplaneWidget() {
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    final shareProvider = Provider.of<ShareProvider>(context);
    final achievementProvider = Provider.of<AchievementProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = UserPreferences();
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          shareProvider.takeScreenshot
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: prefs.darkMode
                      ? Image.asset(
                          ISOTYPE_LARGE_LIGHT,
                          height: 60,
                        )
                      : Image.asset(
                          ISOTYPE_LARGE_DARK,
                          height: 60,
                        ),
                )
              : SizedBox.shrink(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Text(
                    '${widget.paperplane.fecha!.day} de ${MesesData.meses[widget.paperplane.fecha!.month - 1].id}, ${widget.paperplane.fecha!.year}'.toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.036,
                        )),
                Spacer(),
                shareProvider.takeScreenshot
                    ? SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          //aumentar contador en base de datos infoApp
                          //infoProvider.actualizarInformacionApp('aumentar');
                          //
                          achievementProvider.achievementsCheck('compartidos');
                          shareProvider.takeScreenshot = true;
                          shareProvider.takeScreenshotandShare(screenshotController, widget.paperplane.frase!, widget.paperplane.santo!);
                          authProvider.updatePaperplanesShared();
                        },
                        icon: Icon(Iconsax.export_1, size: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(0),
                      ),
                shareProvider.takeScreenshot
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: Icon(Iconsax.more),
                        onPressed: () {
                          showFloatingModalBottomSheet<bool?>(
                              backgroundColor: Theme.of(context).primaryColor,
                              context: context,
                              builder: (context) {
                                return paperplaneBottomSheet();
                              });
                        },
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Chip(
                visualDensity: VisualDensity.comfortable,
                label: Text(
                  widget.paperplane.tag!.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03, 
                      fontWeight: FontWeight.bold, 
                      color: Theme.of(context).primaryColor,
                    ),
                ),
                backgroundColor: ColorPalette.accent,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              widget.paperplane.frase!,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                  ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.06),
          Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  widget.paperplane.santo!,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                  textAlign: TextAlign.end,
                ),
              )),
          SizedBox(height: MediaQuery.of(context).size.width * 0.06),
          reflexionOpen
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Icon(
                    Iconsax.arrow_up_2,
                    color: (reflexionOpen || paperplaneProvider.compartirAvioncito) ? Colors.transparent : Theme.of(context).primaryColorDark,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
          AnimatedContainer(
              duration: Duration(milliseconds: DURATION_MS),
              curve: Curves.easeInOut,
              height: reflexionOpen ? Align().heightFactor : 00.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorDark.withOpacity(0.05),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.paperplane.reflexion!,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                        ),
                        Divider(
                          height: 40,
                        ),
                        Text('Construido por ${widget.paperplane.usuario}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: MediaQuery.of(context).size.width * SCALE_BODY, color: Theme.of(context).primaryColorDark.withOpacity(0.2))),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget paperplaneBottomSheet() {
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context, listen: false);
    final shareProvider = Provider.of<ShareProvider>(context, listen: false);
    final achievementProvider = Provider.of<AchievementProvider>(context, listen: false);
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Iconsax.close_square,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                onTap: () {
                  if (!widget.paperplane.guardado!) {
                    achievementProvider.achievementsCheck('guardados');
                    paperplaneProvider.savePaperplane(widget.paperplane);
                  } else {
                    achievementProvider.decreaseSaved();
                    paperplaneProvider.dontSavePaperplane(widget.paperplane);
                  }
                  Navigator.of(context).pop();
                },
                leading: paperplaneProvider.paperplane!.guardado!
                    ? Icon(Iconsax.archive_slash,
                        size: MediaQuery.of(context).size.width * 0.06,
                        color: paperplaneProvider.compartirAvioncito ? Colors.transparent : Theme.of(context).primaryColorDark)
                    : Icon(Iconsax.archive_1,
                        size: MediaQuery.of(context).size.width * 0.06,
                        color: paperplaneProvider.compartirAvioncito ? Colors.transparent : Theme.of(context).primaryColorDark),
                title: Text('Guardar avioncito',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        )),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  shareProvider.takeScreenshot = true;
                  shareProvider.takeScreenshotandSave(screenshotController);
                },
                leading: donwloadPaperplane
                    ? Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.width * 0.05,
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ))
                    : Icon(Iconsax.receive_square, color: Theme.of(context).primaryColorDark, size: MediaQuery.of(context).size.width * DIMENSION_ICON),
                title: Text(
                  DONWLOAD_PAPERPLANE,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SPACE_SECTION,
                      ),
                ),
              ),
              // ListTile(
              //   onTap: () {
              //     Navigator.of(context).pop();
              //   },
              //   leading: Icon(Iconsax.message_text,
              //       color: Theme.of(context).primaryColorDark,
              //       size: MediaQuery.of(context).size.width * 0.06),
              //   title: Text('Solicitar corrección',
              //       style: Theme.of(context).textTheme.headline6!.copyWith(
              //             fontSize: MediaQuery.of(context).size.width * 0.04,
              //           )),
              // ),
              Divider(
                height: 20,
                indent: 20,
                endIndent: 20,
                color: Theme.of(context).primaryColorDark,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  children: [
                    Text(
                      BUILD_YOUR_PAPERPLANE_TEXT,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * SCALE_BODY,
                            color: Theme.of(context).primaryColorDark.withOpacity(0.4),
                          ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    TextButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Text(
                  BUILD_YOUR_PAPERPLANE_BTN,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * SCALE_BODY,
                    color: ColorPalette.primaryLight,
                  ),
                ),
              ),
              onPressed: () async {
                drawerProvider.page = DrawerItems.buildPage;
                Navigator.of(context).pushReplacementNamed(dashboardPage);
              },
            ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
