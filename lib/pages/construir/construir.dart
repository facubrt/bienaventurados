import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConstruirPage extends StatefulWidget {
  
  @override
  _ConstruirPageState createState() => _ConstruirPageState();
}

class _ConstruirPageState extends State<ConstruirPage> {
  final TextEditingController _fraseController = TextEditingController();
  final TextEditingController _santoController = TextEditingController();
  final TextEditingController _reflexionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taller de avioncitos',
            style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text('Avioncito en construcción...',
                  style: Theme.of(context).textTheme.headline1),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              child: TextFormField(
                controller: _fraseController,
                autofocus: false,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline1,
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                decoration: InputDecoration(
                  hintText: 'Frase',
                  hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.2)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes ingresar un nombre para continuar';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              child: TextFormField(
                controller: _santoController,
                autofocus: false,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline1,
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                decoration: InputDecoration(
                  hintText: 'Santo',
                  hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.2)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes ingresar un nombre para continuar';
                  } else {
                    return null;
                  }
                },
              ),
              
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              child: TextFormField(
                controller: _reflexionController,
                autofocus: false,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline1,
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                minLines: 4,
                maxLines: 8,
                maxLength: 200,
                decoration: InputDecoration(
                  hintText: 'Reflexión',
                  hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.2)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes ingresar un nombre para continuar';
                  } else {
                    return null;
                  }
                },
              ),),
              Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              child: TextFormField(
                controller: _tagController,
                autofocus: false,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline1,
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                decoration: InputDecoration(
                  hintText: 'Tag',
                  hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.2)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes ingresar un nombre para continuar';
                  } else {
                    return null;
                  }
                },
              ),),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: InkWell(
                  onTap: () async {
                    setState(() {
                          _construirNuevoAvioncito();
                          _fraseController.clear();
                          _santoController.clear();
                          _reflexionController.clear();
                          _tagController.clear();
                        });
                  },
                  child: Text(
                    'Hacer volar',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).colorScheme.secondary),
                  ),
                )
                ),
            
          ],
        ),
      ),
    );
  }

  void _construirNuevoAvioncito() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference avioncitoRef = _db.collection('datosApp').doc();

    avioncitoRef.set({
      'frase': _fraseController.text,
      'santo': _santoController.text,
      'reflexion': _reflexionController.text,
      'tag': _tagController.text,
    });
  }
}
