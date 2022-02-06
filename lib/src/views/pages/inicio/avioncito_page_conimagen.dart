import 'dart:io';
import 'dart:typed_data';
import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:iconsax/iconsax.dart';
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
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageFile;
  bool capturandoScreen = false;
  bool capturarPantalla = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: avioncitoWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0),
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
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              padding: EdgeInsets.symmetric(horizontal: 20),
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
          ],
        ),
      ),
    );
  }

  Widget avioncitoWidget() {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Text(
                  '${widget.avioncito.fecha!.day} de ${MesesData.meses[widget.avioncito.fecha!.month - 1].id}, ${widget.avioncito.fecha!.year}'
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                ),
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
                    setState(
                      () {
                        capturandoScreen = true;
                      },
                    );
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
          SizedBox(height: MediaQuery.of(context).size.width * 0.04),
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
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.16),
        ],
      ),
    );
  }

  void _takeScreenshotandShare(String frase, String santo) async {
    _imageFile = null;

    await screenshotController
        .capture(delay: Duration(milliseconds: 20), pixelRatio: 10.0)
        .then(
      (image) async {
        setState(() {
          _imageFile = image;
        });
        final directory = (await getApplicationDocumentsDirectory()).path;
        Uint8List pngBytes = _imageFile!;
        File imgFile = File('$directory/bienaventurados.png');
        await imgFile.writeAsBytes(pngBytes);
        setState(() {
          capturandoScreen = false;
        });
        //await Share.file('Hace volar palabras de amor', 'bienaventurados.png', pngBytes, 'image/png');
        await Share.shareFiles(['$directory/bienaventurados.png'],
            text: '"$frase" -$santo');
      },
    ).catchError(
      (onError) {
        print(onError);
      },
    );
  }
}
