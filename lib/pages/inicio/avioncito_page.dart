import 'dart:io';
import 'dart:typed_data';
import 'package:bienaventurados/data/local/meses.dart';
import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/theme/colores.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:bienaventurados/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class AvioncitoPage extends StatefulWidget {
  final VoidCallback? openDrawer;
  final Avioncito avioncito;

  const AvioncitoPage({Key? key, required this.avioncito, this.openDrawer})
      : super(key: key);

  @override
  _AvioncitoPageState createState() => _AvioncitoPageState();
}

class _AvioncitoPageState extends State<AvioncitoPage> {
  late double? reflexionHeight;
  late bool reflexionOpen;

  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageFile;
  bool capturandoScreen = false;
  bool capturarPantalla = false;

  @override
  void initState() {
    super.initState();
    reflexionHeight = 0;
    reflexionOpen = false;
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: (widget.openDrawer != null)
            ? Colors.transparent
            : Theme.of(context).primaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Screenshot(
                    controller: screenshotController,
                    child: Container(
                      child: avioncitoWidget(),
                    )
                    ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: (widget.openDrawer != null)
                    ? AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                          onPressed: () {
                            widget.openDrawer!();
                          },
                          icon: Icon(FlutterIcons.menu_fea,
                              size: MediaQuery.of(context).size.width * 0.06),
                        ))
                    : AppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        elevation: 0.0,
                        actions: [
                          IconButton(
                            icon: Icon(
                              FlutterIcons.x_fea,
                              size: MediaQuery.of(context).size.width * 0.06,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
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
                              .copyWith(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Colores.primarioDay),
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

  Widget avioncitoWidget() {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.width * 0.2,),
          capturandoScreen 
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Image.asset('assets/images/isotipo.png', height: 40, width: 40, color: Theme.of(context).primaryColorDark),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Text(
                    'Bienaventurados',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).primaryColorDark,
                    ),
                    ),
                ],
              ),
            ),
          )
          : SizedBox.shrink(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Text(
                    '${widget.avioncito.fecha!.day} de ${Meses.meses[widget.avioncito.fecha!.month - 1].id}, ${widget.avioncito.fecha!.year}'
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        )),
                Spacer(),
                IconButton(
                  onPressed: () {
                    if (!widget.avioncito.guardado!) {
                      avioncitoProvider.guardarAvioncito(widget.avioncito);
                    } else {
                      avioncitoProvider.noGuardarAvioncito(widget.avioncito);
                    }
                  },
                  icon: widget.avioncito.guardado!
                      ? Icon(FlutterIcons.bookmark_mco,
                          size: MediaQuery.of(context).size.width * 0.06,
                          color: capturandoScreen
                              ? Colors.transparent
                              : Theme.of(context).primaryColorDark)
                      : Icon(FlutterIcons.bookmark_outline_mco,
                          size: MediaQuery.of(context).size.width * 0.06,
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
                      widget.avioncito.frase!,
                      widget.avioncito.santo!,
                    );
                  },
                  icon: Icon(FlutterIcons.share_fea,
                      size: MediaQuery.of(context).size.width * 0.06,
                      color: capturandoScreen
                          ? Colors.transparent
                          : Theme.of(context).primaryColorDark),
                  padding: EdgeInsets.all(0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Chip(
                  visualDensity: VisualDensity.comfortable,
                  label: Text(widget.avioncito.tag!.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              widget.avioncito.frase!,
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
                  widget.avioncito.santo!,
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
                  padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                  child: Icon(
                    FlutterIcons.chevron_up_fea,
                    color: (reflexionOpen || capturandoScreen)
                        ? Colors.transparent
                        : Theme.of(context).primaryColorDark,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
          AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: reflexionOpen ? Align().heightFactor : 0.0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
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
                          widget.avioncito.reflexion!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                        ),
                        Divider(
                          height: 40,
                        ),
                        Text('Construido por ${widget.avioncito.usuario}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.2))),
                      ],
                    ),
                  ),
                ),
              )),
          capturandoScreen ? SizedBox.shrink() 
            : InkWell(
              onTap: () {
                mostrarMensaje();
              },
              child: Text(
                '¿Ya recibiste este avioncito?'
                ),
            ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.06),
        ],
      ),
    );
  }

  void mostrarMensaje() {
    showFloatingModalBottomSheet(
          backgroundColor: Theme.of(context).primaryColor,
          context: context,
          builder: (context) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Este avioncito lo conozco...',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.04)),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    Text(
                      'Bienaventurados todavía está en crecimiento.\n\n¡Animate a ser parte construyendo tus propios avioncitos!',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    InkWell(
                          onTap: () {
                            // Navigator.of(context).pushReplacementNamed(construirPage, arguments: widget.openDrawer);
                            Navigator.of(context).pop();
                            //Navigator.of(context).popAndPushNamed(construirPage, arguments: widget.openDrawer);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Construir'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color:
                                          Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            );
          },
        );
  }

  void _takeScreenshotandShare(String frase, String santo) async {
    _imageFile = null;

    await screenshotController
        .capture(delay: Duration(milliseconds: 20), pixelRatio: 10.0)
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

  // CODIGO PARA GUARDAR AVIONCITO EN GALERÍA

  // IconButton(
  //   onPressed: () {},
  //   icon: Icon(FlutterIcons.download_fea,
  //       size: MediaQuery.of(context).size.width * 0.06,
  //       color: capturandoScreen
  //           ? Colors.transparent
  //           : Theme.of(context).primaryColorDark),
  //   padding: EdgeInsets.all(0),
  // ),
  // PopupMenuButton(
  //   color: Theme.of(context).primaryColor,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(16.0),
  //   ),
  //   icon: Icon(Icons.more_vert),
  //   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
  //     PopupMenuItem(
  //       child: ListTile(
  //         onTap: () {
  //           Navigator.of(context).pop();
  //           setState(() {
  //             capturandoScreen = true;
  //           });
  //           _takeScreenshotandShare(
  //             widget.avioncito.frase!,
  //             widget.avioncito.santo!,
  //           );
  //         },
  //         leading: Icon(FlutterIcons.share_fea,
  //             size: MediaQuery.of(context).size.width * 0.06,
  //             color: Theme.of(context).primaryColorDark),
  //         title: Text(
  //           'Hacer volar',
  //           style: Theme.of(context)
  //               .textTheme
  //               .headline6!
  //               .copyWith(
  //                 fontSize:
  //                     MediaQuery.of(context).size.width * 0.04,
  //               ),
  //         ),
  //       ),
  //     ),
  //     PopupMenuItem(
  //       child: ListTile(
  //         onTap: () {
  //           //Navigator.of(context).pushNamed(compartirPage);
  //           Navigator.of(context).pop();
  //           setState(() {
  //             capturandoScreen = true;
  //           });
  //           _takeScreenshotandSave();
  //         },
  //         leading: Icon(FlutterIcons.download_fea,
  //             color: Theme.of(context).primaryColorDark,
  //             size: MediaQuery.of(context).size.width * 0.06),
  //         title: Text('Descargar',
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .headline6!
  //                 .copyWith(
  //                   fontSize:
  //                       MediaQuery.of(context).size.width * 0.04,
  //                 )),
  //       ),
  //     ),
  //   ],
  // ),

/*
  void _takeScreenshotandSave() async {
    _imageFile = null;
    int _dia = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1, 0, 0))
        .inDays;
    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('¡Has capturado este avioncito! Puedes verlo en tu galería',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );
    await screenshotController
        .capture(delay: Duration(milliseconds: 20), pixelRatio: 10.0)
        .then((image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile!;
      File imgFile = File('$directory/bienaventurados.png');
      await imgFile.writeAsBytes(pngBytes);
      await ImageGallerySaver.saveImage(pngBytes,
          quality: 100, name: 'bienaventurados-$_dia');
      print('File Saved to Gallery');
      setState(() {
        capturandoScreen = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }).catchError((onError) {
      print(onError);
    });
  }
*/
}
