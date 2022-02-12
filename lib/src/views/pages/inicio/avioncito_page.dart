import 'dart:typed_data';
import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:bienaventurados/src/logic/providers/compartir_provider.dart';
import 'package:bienaventurados/src/logic/providers/logro_provider.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

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
  bool compartir = false;
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
    final compartirProvider = Provider.of<CompartirProvider>(context);
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
                      transform: Matrix4.identity()
                        ..scale(compartirProvider.compartiendo ? 0.72 : 1.0,
                            compartirProvider.compartiendo ? 0.72 : 1.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: compartirProvider.compartiendo
                            ? Border.all(
                                width: 4,
                                color: Theme.of(context).primaryColorDark)
                            : Border.all(
                                width: 0.0,
                                color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: avioncitoWidget(),
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
                        size: MediaQuery.of(context).size.width * 0.06,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              compartirProvider.compartiendo
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
    final compartirProvider = Provider.of<CompartirProvider>(context);
    final prefs = PreferenciasUsuario();
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          compartirProvider.compartiendo
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: prefs.modoNoche
                      ? Image.asset(
                          'assets/images/isotipo-horizontal-claro.png',
                          height: 60,
                        )
                      : Image.asset(
                          'assets/images/isotipo-horizontal-oscuro.png',
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
                    '${widget.avioncito.fecha!.day} de ${MesesData.meses[widget.avioncito.fecha!.month - 1].id}, ${widget.avioncito.fecha!.year}'
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        )),
                Spacer(),
                compartirProvider.compartiendo
                    ? SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          compartirProvider.compartiendo = true;
                          compartirProvider.takeScreenshotandShare(
                              screenshotController,
                              widget.avioncito.frase!,
                              widget.avioncito.santo!);
                          //Navigator.of(context).pushNamed(compartirPage, arguments: widget.avioncito);
                        },
                        icon: Icon(Iconsax.export_1,
                            size: MediaQuery.of(context).size.width * 0.06,
                            color: Theme.of(context).primaryColorDark),
                        padding: EdgeInsets.all(0),
                      ),
                compartirProvider.compartiendo
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: Icon(Iconsax.more),
                        onPressed: () {
                          showFloatingModalBottomSheet<bool?>(
                              backgroundColor: Theme.of(context).primaryColor,
                              context: context,
                              builder: (context) {
                                return avioncitoBottomSheet();
                              });
                          // ).then((refrescar) {
                          //   if (refrescar != null && refrescar) {
                          //     if (descargarAvioncito) {
                          //       compartirProvider
                          //           .takeScreenshotandSave(screenshotController);
                          //     }
                          //   }
                          // });
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
                label: Text(widget.avioncito.tag!.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
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
                  padding: const EdgeInsets.only(bottom: 30),
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
                                .subtitle1!
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
    final logroProvider = Provider.of<LogroProvider>(context, listen: false);
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
                  if (!widget.avioncito.guardado!) {
                    logroProvider.comprobacionLogros('guardados');
                    avioncitoProvider.guardarAvioncito(widget.avioncito);
                  } else {
                    avioncitoProvider.noGuardarAvioncito(widget.avioncito);
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
                title: Text('Guardar avioncito',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        )),
              ),
              ListTile(
                onTap: () {
                  descargarAvioncito = true;
                  Navigator.of(context).pop(true);
                },
                leading: descargarAvioncito
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
                    : Icon(Iconsax.receive_square,
                        color: Theme.of(context).primaryColorDark,
                        size: MediaQuery.of(context).size.width * 0.06),
                title: Text(
                  'Descargar avioncito',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                ),
              ),
              // ListTile(
              //   onTap: () {
              //     Navigator.of(context).pushNamed(compartirPage, arguments: widget.avioncito);
              //   },
              //   leading: Icon(Iconsax.export_1,
              //       size: MediaQuery.of(context).size.width * 0.06,
              //       color: Theme.of(context).primaryColorDark),
              //   title: Text('Compartir avioncito',
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
                title: Text('Solicitar corrección',
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
            ],
          ),
        ),
      );
    });
  }
}
