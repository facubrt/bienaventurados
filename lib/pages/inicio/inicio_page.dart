import 'dart:typed_data';
import 'package:bienaventurados/data/local/meses.dart';
import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
//import 'package:bienaventurados/providers/local_notifications.dart';
import 'package:bienaventurados/theme/colores.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'dart:io';

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
    final avioncitoProvider =
        Provider.of<AvioncitoProvider>(context, listen: false);
    avioncitoProvider.configuracionInicial();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
          onVerticalDragUpdate: (details) {
            print(details.primaryDelta!);
            if (details.primaryDelta! < -7) {
              setState(() {
                reflexionHeight = MediaQuery.of(context).size.height / 6;
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
                      controller: screenshotController, child: avioncitoWidget()),
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
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 30.0, bottom: 4.0),
                        child: InkWell(
                          onTap: () {
                            widget.openDrawer();
                          },
                          child: Icon(FlutterIcons.menu_fea, size: 24),
                        ),
                      ),
                      title: Text(
                        'Bendecido día',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      backgroundColor: Colores.primarioDay.withOpacity(0),
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
                color: Theme.of(context).primaryColor,
              ),
              Positioned(
                  top: 130,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: reflexionOpen ? 100 : 120,
                      width: reflexionOpen ? 100 : 120,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Image.asset(
                          "assets/images/iso.png",
                          color: Theme.of(context).primaryColorDark,
                          isAntiAlias: true,
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        Text(
                            '${DateTime.now().day} de ${Meses.meses[DateTime.now().month - 1].id}, ${DateTime.now().year}'
                                .toUpperCase(),
                            style: Theme.of(context).textTheme.subtitle1),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            print('Guardar avioncito');
                          },
                          child: Icon(FlutterIcons.bookmark_fea,
                              size: 22,
                              color: capturandoScreen
                                  ? Colors.transparent
                                  : Theme.of(context).primaryColorDark),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(compartirPage);
                          //   setState(() {
                          //     capturandoScreen = true;
                          //   });
                          //   _takeScreenshotandShare(
                          //       avioncitoProvider.avioncito!.frase!,
                          //       avioncitoProvider.avioncito!.santo!);
                          },
                          child: Icon(FlutterIcons.share_fea,
                              size: 22,
                              color: capturandoScreen
                                  ? Colors.transparent
                                  : Theme.of(context).primaryColorDark),
                        ),
                      ],
                    ),
                    Chip(
                      label: Text(avioncitoProvider.avioncito!.usuario!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(height: 40),
                    Text(
                      avioncitoProvider.avioncito!.frase!,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        avioncitoProvider.avioncito!.santo!,
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: 40),
                    AnimatedContainer(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), 
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),),
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        height: reflexionHeight,
                        child: avioncitoProvider.avioncitoListo
                            ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                  avioncitoProvider.avioncito!.reflexion!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                            )
                            : Text(
                                'Cargando...',
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                  ],
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}
