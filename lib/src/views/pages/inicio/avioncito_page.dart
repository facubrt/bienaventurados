import 'dart:io';
import 'dart:typed_data';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:bienaventurados/src/views/pages/compartir/compartir_avioncito.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class AvioncitoPage extends StatefulWidget {
  final Avioncito avioncito;

  const AvioncitoPage({Key? key, required this.avioncito}) : super(key: key);

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
  bool descargarAvioncito = false;
  bool guardado = false;

  @override
  void initState() {
    super.initState();
    reflexionHeight = 0;
    reflexionOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
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
      child:
          // Scaffold(
          //   backgroundColor: (widget.openDrawer != null)
          //       ? Colors.transparent
          //       : Theme.of(context).primaryColor,
          //   body:
          Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                Iconsax.close_square,
                size: MediaQuery.of(context).size.width * 0.06,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Screenshot(
                  controller: screenshotController,
                  child: Container(
                    child: avioncitoWidget(),
                  )),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.2,
              //   child: (widget.openDrawer != null)
              //       ? AppBar(
              //           backgroundColor: Colors.transparent,
              //           elevation: 0,
              //           leading: IconButton(
              //             onPressed: () {
              //               widget.openDrawer!();
              //             },
              //             icon: Icon(Iconsax.category,
              //                 size: MediaQuery.of(context).size.width * 0.06),
              //           ))
              //       : AppBar(
              //           backgroundColor: Colors.transparent,
              //           automaticallyImplyLeading: false,
              //           elevation: 0.0,
              //           actions: [
              //             IconButton(
              //               icon: Icon(
              //                 Iconsax.close_square,
              //                 size: MediaQuery.of(context).size.width * 0.06,
              //               ),
              //               onPressed: () {
              //                 Navigator.of(context).pop();
              //               },
              //             ),
              //           ],
              //         ),
              // ),
              avioncitoProvider.compartirAvioncito
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Text(
                    '${widget.avioncito.fecha!.day} de ${MesesData.meses[widget.avioncito.fecha!.month - 1].id}, ${widget.avioncito.fecha!.year}'
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        )),
                Spacer(),
                // IconButton(
                //   onPressed: () {
                //     if (!widget.avioncito.guardado!) {
                //       avioncitoProvider.guardarAvioncito(widget.avioncito);
                //     } else {
                //       avioncitoProvider.noGuardarAvioncito(widget.avioncito);
                //     }
                //   },
                //   icon: avioncitoProvider.avioncito!.guardado!
                //       ? Icon(Iconsax.archive_slash,
                //           size: MediaQuery.of(context).size.width * 0.06,
                //           color: avioncitoProvider.compartirAvioncito
                //               ? Colors.transparent
                //               : Theme.of(context).primaryColorDark)
                //       : Icon(Iconsax.archive_1,
                //           size: MediaQuery.of(context).size.width * 0.06,
                //           color: avioncitoProvider.compartirAvioncito
                //               ? Colors.transparent
                //               : Theme.of(context).primaryColorDark),
                //   padding: EdgeInsets.all(0),
                // ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(compartirPage, arguments: widget.avioncito);
                    // setState(() {
                    //   capturandoScreen = true;
                    // });
                    // _takeScreenshotandShare(
                    //   widget.avioncito.frase!,
                    //   widget.avioncito.santo!,
                    // );
                  },
                  icon: Icon(Iconsax.export_1,
                      size: MediaQuery.of(context).size.width * 0.06,
                      color: Theme.of(context).primaryColorDark),
                  padding: EdgeInsets.all(0),
                ),
                IconButton(
                  icon: Icon(Iconsax.more),
                  onPressed: () {
                    showFloatingModalBottomSheet<bool?>(
                      backgroundColor: Theme.of(context).primaryColor,
                      context: context,
                      builder: (context) {
                        return avioncitoBottomSheet();
                      },
                    ).then((refrescar) {
                      if (refrescar != null && refrescar) {
                        if (descargarAvioncito) {
                          _takeScreenshotandSave();
                        }
                        if (avioncitoProvider.compartirAvioncito) {
                          _takeScreenshotandShare(
                            widget.avioncito.frase!,
                            widget.avioncito.santo!,
                          );
                        }
                      }
                    });
                  },
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
                    fontSize: MediaQuery.of(context).size.width * 0.068,
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
                    Iconsax.arrow_up_2,
                    color:
                        (reflexionOpen || avioncitoProvider.compartirAvioncito)
                            ? Colors.transparent
                            : Theme.of(context).primaryColorDark,
                    size: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
          AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: reflexionOpen ? Align().heightFactor : 00.0,
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
                                    MediaQuery.of(context).size.width * 0.032,
                              ),
                        ),
                        Divider(
                          height: 40,
                        ),
                        Text('Construido por ${widget.avioncito.usuario}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
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
    );
  }

  Widget avioncitoBottomSheet() {
    final avioncitoProvider =
        Provider.of<AvioncitoProvider>(context, listen: false);
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  if (!widget.avioncito.guardado!) {
                    avioncitoProvider.guardarAvioncito(widget.avioncito);
                    //guardado = true;
                  } else {
                    avioncitoProvider.noGuardarAvioncito(widget.avioncito);
                    //guardado = false;
                  }
                  Navigator.of(context).pop();
                },
                leading: avioncitoProvider.avioncito!.guardado!
                    ? Icon(Iconsax.archive_slash,
                        size: MediaQuery.of(context).size.width * 0.06,
                        color: avioncitoProvider.compartirAvioncito
                            ? Colors.transparent
                            : Theme.of(context).primaryColorDark)
                    : Icon(Iconsax.archive_1,
                        size: MediaQuery.of(context).size.width * 0.06,
                        color: avioncitoProvider.compartirAvioncito
                            ? Colors.transparent
                            : Theme.of(context).primaryColorDark),
                title: Text('Guardar',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        )),
              ),
              // ListTile(
              //   onTap: () {
              //     descargarAvioncito = true;
              //     Navigator.of(context).pop(true);
              //   },
              //   leading: descargarAvioncito
              //       ? Container(
              //           alignment: Alignment.center,
              //           height: MediaQuery.of(context).size.width * 0.05,
              //           width: MediaQuery.of(context).size.width * 0.05,
              //           child: Center(
              //             child: CircularProgressIndicator(
              //               strokeWidth: 2,
              //               color: Theme.of(context).primaryColorDark,
              //             ),
              //           ))
              //       : Icon(Iconsax.receive_square,
              //           color: Theme.of(context).primaryColorDark,
              //           size: MediaQuery.of(context).size.width * 0.06),
              //   title: Text(
              //     'Descargar',
              //     style: Theme.of(context).textTheme.headline6!.copyWith(
              //           fontSize: MediaQuery.of(context).size.width * 0.04,
              //         ),
              //   ),
              // ),
              // ListTile(
              //   onTap: () {
              //     avioncitoProvider.compartirAvioncito = true;
              //     Navigator.of(context).pop(true);
              //   },
              //   leading: Icon(Iconsax.export_1,
              //       size: MediaQuery.of(context).size.width * 0.06,
              //       color: Theme.of(context).primaryColorDark),
              //   title: Text('Compartir',
              //       style: Theme.of(context).textTheme.headline6!.copyWith(
              //             fontSize: MediaQuery.of(context).size.width * 0.04,
              //           )),
              // ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: Icon(Iconsax.message_text,
                    color: Theme.of(context).primaryColorDark,
                    size: MediaQuery.of(context).size.width * 0.06),
                title: Text('Reportar avioncito',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        )),
              ),
              Divider(
                height: 20,
                indent: 20,
                endIndent: 20,
                color: Theme.of(context).primaryColorDark,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Text(
                  '¿Ya recibiste este avioncito? Ayudanos a construir muchos más avioncitos y sacarlos a pasear. ¡Animate a compartir la fe!',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                      ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Theme.of(context).primaryColor)),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // void otrasOpciones() async {
  //   final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
  //   final bool? shouldRefresh = await showFloatingModalBottomSheet<bool?>(
  //     backgroundColor: Theme.of(context).primaryColor,
  //     context: context,
  //     builder: (context) {
  //       return avioncitoBottomSheet();
  //     },
  //   );

  //   if(shouldRefresh != null && shouldRefresh) {
  //     avioncitoProvider.compartirAvioncito = true;
  //     _takeScreenshotandShare();
  //   }
  // }

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
                        fontSize: MediaQuery.of(context).size.width * 0.04)),
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
                    Navigator.of(context).pop();
                    //Navigator.of(context).pushReplacementNamed(construirPage, arguments: widget.openDrawer);
                    //Navigator.of(context).popAndPushNamed(construirPage, arguments: widget.openDrawer);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'De acuerdo'.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Theme.of(context).primaryColorDark),
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
    // int _atSecond = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1, 0, 0)).inSeconds;
    final avioncitoProvider =
        Provider.of<AvioncitoProvider>(context, listen: false);
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
      // GUARDAMOS EL AVIONCITO EN GALERÍA
      // await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: 'bienaventurados-$_atSecond');
      // print('File Saved to Gallery');
      // setState(() {
      //   capturandoScreen = false;
      // });
      avioncitoProvider.compartirAvioncito = false;
      await Share.shareFiles(['$directory/bienaventurados.png'],
          text: '"$frase" -$santo');
    }).catchError((onError) {
      print(onError);
    });
  }

  void _takeScreenshotandSave() async {
    _imageFile = null;
    // int _dia = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1, 0, 0)).inDays;
    int _atSecond = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1, 0, 0))
        .inSeconds;

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
          quality: 100, name: 'bienaventurados-$_atSecond');
      descargarAvioncito = false;
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }).catchError((onError) {
      print(onError);
    });
  }
}
