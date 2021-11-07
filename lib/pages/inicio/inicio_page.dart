import 'dart:typed_data';
import 'package:bienaventurados/data/local/meses.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
//import 'package:bienaventurados/providers/local_notifications.dart';
import 'package:bienaventurados/theme/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'dart:io';

import 'package:styled_widget/styled_widget.dart';

class InicioPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const InicioPage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  late double? reflexionHeight;
  late bool reflexionOpen;

  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageFile;
  bool capturandoScreen = false;

  @override
  void initState() {
    super.initState();
    reflexionHeight = 0;
    reflexionOpen = false;
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
    avioncitoProvider.configuracionInicial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
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
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Screenshot(
                      controller: screenshotController,
                      child: avioncitoWidget()),
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Icon(
                      FlutterIcons.chevron_up_fea,
                      color: reflexionOpen
                          ? Colors.transparent
                          : Theme.of(context).primaryColorDark,
                      size: 24,
                    ),
                  ),
                  Container(
                    height: 100,
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: IconButton(
                          onPressed: () {
                            widget.openDrawer();
                          },
                          icon: Icon(FlutterIcons.menu_fea, size: 22),
                        ),
                      ),
                      elevation: 0.0,
                    ),
                  ),
                  capturandoScreen
                      ? Container(
                          color: Colores.contrasteDay.withOpacity(0.9),
                          child: Center(
                              child: Text(
                            'Preparando tu avioncito...',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colores.primarioDay),
                          )),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          )),
    );
  }

  void _takeScreenshotandShare(String frase, String santo) async {
    _imageFile = null;
    await screenshotController
        .capture(delay: Duration(milliseconds: 16), pixelRatio: 12.0)
        .then((image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile!;
      File imgFile = File('$directory/bienaventurados.png');
      await imgFile.writeAsBytes(pngBytes);
      print('File Saved to Gallery');
      setState(() {
        capturandoScreen = false;
      });
      //await Share.file('Hace volar palabras de amor', 'bienaventurados.png', pngBytes, 'image/png');
      await Share.shareFiles(['$directory/bienaventurados.png'],
          text: '"$frase" -$santo');
    }).catchError((onError) {
      print(onError);
    });
  }

  Widget avioncitoWidget() {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return avioncitoProvider.avioncitoListo
        ? Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: capturandoScreen
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
              ),
              Positioned(
                  top: 80,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: reflexionOpen ? 90 : 110,
                      width: reflexionOpen ? 90 : 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Image.asset(
                          "assets/images/isotipo.png",
                          color: Theme.of(context).primaryColorDark,
                          isAntiAlias: true,
                        ),
                      ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Row(
                    children: [
                      Text(
                          '${avioncitoProvider.avioncito!.fecha!.day} de ${Meses.meses[avioncitoProvider.avioncito!.fecha!.month - 1].id}, ${avioncitoProvider.avioncito!.fecha!.year}'
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.subtitle1),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          if (!avioncitoProvider.avioncito!.guardado!) {
                            avioncitoProvider.guardarAvioncito();
                          } else {
                            avioncitoProvider.noGuardarAvioncito(avioncitoProvider.avioncito!.id!);
                          }

                          //avioncitoProvider.guardarAvioncito();
                        },
                        icon: avioncitoProvider.avioncito!.guardado!
                            ? Icon(FlutterIcons.bookmark_mco,
                                size: 22,
                                color: capturandoScreen
                                    ? Colors.transparent
                                    : Theme.of(context).primaryColorDark)
                            : Icon(FlutterIcons.bookmark_outline_mco,
                                size: 22,
                                color: capturandoScreen
                                    ? Colors.transparent
                                    : Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(0),
                      ),
                      IconButton(
                        onPressed: () {
                          //Navigator.of(context).pushNamed(compartirPage);
                          setState(() {
                            capturandoScreen = true;
                          });
                          _takeScreenshotandShare(
                              avioncitoProvider.avioncito!.frase!,
                              avioncitoProvider.avioncito!.santo!);
                        },
                        icon: Icon(FlutterIcons.share_fea,
                            size: 22,
                            color: capturandoScreen
                                ? Colors.transparent
                                : Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(0),
                      ),
                    ],
                  ).padding(horizontal: 40),
                  Row(
                    children: [
                      Chip(
                        visualDensity: VisualDensity.comfortable,
                        label: Text(
                            avioncitoProvider.avioncito!.tag!.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor)),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ).padding(horizontal: 40),
                  SizedBox(height: 40),
                  Text(
                    avioncitoProvider.avioncito!.frase!,
                    style: Theme.of(context).textTheme.headline1,
                  ).padding(horizontal: 40),
                  SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      avioncitoProvider.avioncito!.santo!,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.end,
                    ).padding(left: 40, right: 40),
                  ),
                  SizedBox(height: 60),
                  AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: reflexionOpen ? Align().heightFactor : 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.05),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  avioncitoProvider.avioncito!.reflexion!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Divider(
                                  height: 40,
                                ),
                                Text(
                                    'Construido por ${avioncitoProvider.avioncito!.usuario}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColorDark
                                                .withOpacity(0.2))),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}
