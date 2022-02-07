import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class CompartirProvider with ChangeNotifier {
  Offset _position = Offset.zero;
  bool _isDragging = false;
  bool _compartiendo = false;
  bool _descargando = false;
  Uint8List? _imageFile;
  ScreenshotController screenshot11Controller = ScreenshotController();

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final delta = 40;
    if (_position.dy >= delta || _position.dy <= -delta) {
      resetPosition();
    }

    notifyListeners();
  }

  void endPosition(
      ScreenshotController controller, String frase, String santo) {
    _isDragging = false;
    final y = _position.dy;
    final delta = 10;
    notifyListeners();
    if (y >= delta) {
      HapticFeedback.vibrate();
      print('DESCARGAR');
      _descargando = true;
      _takeScreenshotandSave(controller);
      notifyListeners();
    } else if (y <= -delta) {
      HapticFeedback.vibrate();
      print('COMPARTIR');
      _compartiendo = true;
      _takeScreenshotandShare(controller, frase, santo);
      notifyListeners();
    }
    resetPosition();
  }

  void _takeScreenshotandShare(
      ScreenshotController controller, String frase, String santo) async {
    _imageFile = null;
    await controller
        .capture(delay: Duration(milliseconds: 20), pixelRatio: 10.0)
        .then((image) async {
      _imageFile = image;

      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile!;
      File imgFile = File('$directory/bienaventurados.png');
      await imgFile.writeAsBytes(pngBytes);
      await Share.shareFiles(['$directory/bienaventurados.png'],
          text: '"$frase" -$santo');
    }).catchError((onError) {
      print(onError);
    });
    _compartiendo = false;
    notifyListeners();
  }

  void _takeScreenshotandSave(ScreenshotController controller) async {
    _imageFile = null;
    int _atSecond = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1, 0, 0))
        .inSeconds;
    await controller
        .capture(delay: Duration(milliseconds: 20), pixelRatio: 10.0)
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
    _descargando = false;
    notifyListeners();
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
  }

  bool get compartiendo => _compartiendo;
  bool get descargando => _descargando;
  bool get isDragging => _isDragging;
  Offset get position => _position;
}
