import 'dart:typed_data';
import 'package:bienaventurados/data/local/meses.dart';
import 'package:bienaventurados/providers/auth_provider.dart';
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
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          print(details.primaryDelta!);
          if (details.primaryDelta! < -7) {
            setState(() {
              reflexionHeight = MediaQuery.of(context).size.height / 5;
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
                      'Bendecido día, ${authProvider.usuario.nombre == null ? '' : authProvider.usuario.nombre}',
                      style: Theme.of(context).textTheme.headline6,
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
                    : Visibility(
                        visible: false,
                        child: Container(),
                      ),
              ],
            ),
          ),
        ));
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
                // child: Padding(
                //   padding: const EdgeInsets.only(left: 20.0, right: 20, top: 120, bottom: 20 ),
                //   child: Container(
                //     decoration: capturandoScreen
                //     ? BoxDecoration(border: Border.all(width: 4, color: Theme.of(context).primaryColorDark))
                //     : BoxDecoration(),
                //   ),
                // ),
              ),
              Positioned(
                  top: 130,
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Image.asset(
                      "assets/images/iso.png",
                      width: 80,
                      height: 80,
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
                            setState(() {
                              capturandoScreen = true;
                            });
                            _takeScreenshotandShare(
                                avioncitoProvider.avioncito!.frase!,
                                avioncitoProvider.avioncito!.santo!);
                          },
                          child: Icon(FlutterIcons.share_fea,
                              size: 22,
                              color: capturandoScreen
                                  ? Colors.transparent
                                  : Theme.of(context).primaryColorDark),
                        ),
                      ],
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
                    Divider(
                                height: 40,
                                color: reflexionOpen
                                    ? Theme.of(context).primaryColorDark
                                    : Colors.transparent,
                                thickness: 4,
                                endIndent:
                                    MediaQuery.of(context).size.width - 120,
                              ),
                    AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        height: reflexionHeight,
                        child: avioncitoProvider.avioncitoListo
                            ? Text(
                              avioncitoProvider.avioncito!.reflexion!,
                              style:
                                  Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.justify,
                            )
                            : Text(
                                'Cargando...',
                                style:
                                    Theme.of(context).textTheme.bodyText1,
                              )),
                  ],
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}
