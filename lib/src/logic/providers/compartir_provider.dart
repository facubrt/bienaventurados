import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class CompartirProvider with ChangeNotifier {
  bool _capturando = false;
  Uint8List? _imageFile;

  // FUNCIONES
  void takeScreenshotandShare(
      ScreenshotController controller, String frase, String santo) async {
    _imageFile = null;
    await controller
        .capture(delay: Duration(milliseconds: 310), pixelRatio: 6.0)
        .then((image) async {
      _imageFile = image;
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile!;
      File imgFile = File('$directory/bienaventurados.png');
      await imgFile.writeAsBytes(pngBytes);
      await Share.shareFiles(['$directory/bienaventurados.png'],
          text: '"$frase" -$santo #bienaventurados #avioncitodehoy @sereucaristía');
    }).catchError((onError) {
      print(onError);
    });
    _capturando = false;
    notifyListeners();
  }

    void compartirColeccionable(
      ScreenshotController controller, String titulo) async {
    _imageFile = null;
    await controller
        .capture(delay: Duration(milliseconds: 310), pixelRatio: 6.0)
        .then((image) async {
      _imageFile = image;
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile!;
      File imgFile = File('$directory/bienaventurados.png');
      await imgFile.writeAsBytes(pngBytes);
      await Share.shareFiles(['$directory/bienaventurados.png'],
          text: '¡Obtuve el coleccionable "$titulo" en #Bienaventurados la aplicación de Ser Eucaristía!');
    }).catchError((onError) {
      print(onError);
    });
    _capturando = false;
    notifyListeners();
  }

  void takeScreenshotandSave(ScreenshotController controller) async {
    _imageFile = null;
    int _atSecond = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1, 0, 0))
        .inSeconds;
    await controller
        .capture(delay: Duration(milliseconds: 310), pixelRatio: 6.0)
        .then((image) async {
      _imageFile = image;
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile!;
      File imgFile = File('$directory/bienaventurados.png');
      await imgFile.writeAsBytes(pngBytes);
      await ImageGallerySaver.saveImage(pngBytes,
          quality: 100, name: 'bienaventurados-$_atSecond');
    }).catchError((onError) {
      print(onError);
    });
    _capturando = false;
    notifyListeners();
  }

  // GETTERS AND SETTERS
  bool get capturando => _capturando;
  set capturando(bool compartir) {
    _capturando = compartir;
    notifyListeners();
  }
}
