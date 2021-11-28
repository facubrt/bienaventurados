import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditarPage extends StatefulWidget {
  final String? frase;
  final String? santo;
  final String? reflexion;
  final String? tag;
  final String? usuario;
  final String? id;

  const EditarPage({ Key? key, required this.frase, required this.santo, required this.reflexion, required this.tag, required this.usuario, required this.id }) : super(key: key);

  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {
  final TextEditingController _fraseController = TextEditingController();
  final TextEditingController _santoController = TextEditingController();
  final TextEditingController _reflexionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _preguntaController = TextEditingController();
  final TextEditingController _misionController = TextEditingController();
  final fraseFormKey = GlobalKey<FormState>();
  final reflexionFormKey = GlobalKey<FormState>();
  final preguntaFormKey = GlobalKey<FormState>();

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _fraseController.text = widget.frase as String;
    _santoController.text = widget.santo as String;
    _reflexionController.text = widget.reflexion as String;
    _tagController.text = widget.tag as String;
    _usuarioController.text = widget.usuario as String;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          fraseWidget(),
          reflexionWidget(),
          preguntaWidget(),
          avioncitoListoWidget(),
        ],
      ),
    );
  }

  Widget fraseWidget() {
    return Form(
      key: fraseFormKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('¿Construimos un avioncito juntos?',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _fraseController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  minLines: 1,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Frase',
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.2)),
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
                SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
                TextFormField(
                  controller: _santoController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: 'Santo, versículo, ...',
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.2)),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                if (fraseFormKey.currentState!.validate()) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 1200),
                      curve: Curves.fastLinearToSlowEaseIn);
                }
              },
              child: Text('Siguiente',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
      ),
    );
  }

  Widget reflexionWidget() {
    return Form(
      key: reflexionFormKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text('¿Qué reflexión te gustaría hacer sobre estas palabras?',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _reflexionController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  minLines: 1,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Reflexión',
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.2)),
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
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _tagController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: 'Tag',
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.2)),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                if (reflexionFormKey.currentState!.validate()) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 1200),
                      curve: Curves.fastLinearToSlowEaseIn);

                }
              },
              child: Text('Siguiente',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
      ),
    );
  }

  Widget preguntaWidget() {
    return Form(
      key: preguntaFormKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text('Un último paso antes de hacer volar tu avioncito',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _preguntaController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: 'Pregunta (opcional)',
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.2)),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _misionController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: 'Misión (opcional)',
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.2)),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                if (preguntaFormKey.currentState!.validate()) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    _construirNuevoAvioncito();
                    _deleteAvioncitoUsuario(widget.id);
                    _fraseController.clear();
                    _santoController.clear();
                    _reflexionController.clear();
                    _tagController.clear();
                    _preguntaController.clear();
                    _misionController.clear();
                  });
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 1200),
                      curve: Curves.fastLinearToSlowEaseIn);
                }
              },
              child: Text('Continuar',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
      ),
    );
  }

  Widget avioncitoListoWidget() {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Text(
            '¡Todo listo!',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
          child: Text(
              'Este avioncito ya salió volando y llegará pronto a muchos corazones!',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  )),
        )
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          width: double.infinity,
          height: 50,
          child: TextButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Finalizar',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Theme.of(context).primaryColor)),
          ),
        ),
      ),
    );
  }

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Taller de avioncitos',
  //           style: Theme.of(context).textTheme.headline6),
  //       elevation: 0.0,
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(40.0),
  //             child: Text('Avioncito en construcción...',
  //                 style: Theme.of(context).textTheme.headline1),
  //           ),
  //           Padding(
  //             padding:
  //                 const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
  //             child: TextFormField(
  //               controller: _fraseController,
  //               autofocus: false,
  //               keyboardType: TextInputType.text,
  //               style: Theme.of(context).textTheme.headline1,
  //               cursorColor: Theme.of(context).primaryColorDark,
  //               cursorWidth: 4,
  //               decoration: InputDecoration(
  //                 hintText: 'Frase',
  //                 hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
  //                     color:
  //                         Theme.of(context).primaryColorDark.withOpacity(0.2)),
  //                 focusedBorder: InputBorder.none,
  //                 border: InputBorder.none,
  //                 errorBorder: InputBorder.none,
  //                 enabledBorder: InputBorder.none,
  //                 disabledBorder: InputBorder.none,
  //                 focusedErrorBorder: InputBorder.none,
  //               ),
  //               validator: (value) {
  //                 if (value!.isEmpty) {
  //                   return 'Debes ingresar un nombre para continuar';
  //                 } else {
  //                   return null;
  //                 }
  //               },
  //             ),
  //           ),
  //           Padding(
  //             padding:
  //                 const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
  //             child: TextFormField(
  //               controller: _santoController,
  //               autofocus: false,
  //               keyboardType: TextInputType.text,
  //               style: Theme.of(context).textTheme.headline1,
  //               cursorColor: Theme.of(context).primaryColorDark,
  //               cursorWidth: 4,
  //               decoration: InputDecoration(
  //                 hintText: 'Santo',
  //                 hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
  //                     color:
  //                         Theme.of(context).primaryColorDark.withOpacity(0.2)),
  //                 focusedBorder: InputBorder.none,
  //                 border: InputBorder.none,
  //                 errorBorder: InputBorder.none,
  //                 enabledBorder: InputBorder.none,
  //                 disabledBorder: InputBorder.none,
  //                 focusedErrorBorder: InputBorder.none,
  //               ),
  //               validator: (value) {
  //                 if (value!.isEmpty) {
  //                   return 'Debes ingresar un nombre para continuar';
  //                 } else {
  //                   return null;
  //                 }
  //               },
  //             ),
              
  //           ),
  //           Padding(
  //             padding:
  //                 const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
  //             child: TextFormField(
  //               controller: _reflexionController,
  //               autofocus: false,
  //               keyboardType: TextInputType.text,
  //               style: Theme.of(context).textTheme.headline1,
  //               cursorColor: Theme.of(context).primaryColorDark,
  //               cursorWidth: 4,
  //               minLines: 4,
  //               maxLines: 8,
  //               maxLength: 200,
  //               decoration: InputDecoration(
  //                 hintText: 'Reflexión',
  //                 hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
  //                     color:
  //                         Theme.of(context).primaryColorDark.withOpacity(0.2)),
  //                 focusedBorder: InputBorder.none,
  //                 border: InputBorder.none,
  //                 errorBorder: InputBorder.none,
  //                 enabledBorder: InputBorder.none,
  //                 disabledBorder: InputBorder.none,
  //                 focusedErrorBorder: InputBorder.none,
  //               ),
  //               validator: (value) {
  //                 if (value!.isEmpty) {
  //                   return 'Debes ingresar un nombre para continuar';
  //                 } else {
  //                   return null;
  //                 }
  //               },
  //             ),),
  //             Padding(
  //             padding:
  //                 const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
  //             child: TextFormField(
  //               controller: _tagController,
  //               autofocus: false,
  //               keyboardType: TextInputType.text,
  //               style: Theme.of(context).textTheme.headline1,
  //               cursorColor: Theme.of(context).primaryColorDark,
  //               cursorWidth: 4,
  //               decoration: InputDecoration(
  //                 hintText: 'Tag',
  //                 hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
  //                     color:
  //                         Theme.of(context).primaryColorDark.withOpacity(0.2)),
  //                 focusedBorder: InputBorder.none,
  //                 border: InputBorder.none,
  //                 errorBorder: InputBorder.none,
  //                 enabledBorder: InputBorder.none,
  //                 disabledBorder: InputBorder.none,
  //                 focusedErrorBorder: InputBorder.none,
  //               ),
  //               validator: (value) {
  //                 if (value!.isEmpty) {
  //                   return 'Debes ingresar un nombre para continuar';
  //                 } else {
  //                   return null;
  //                 }
  //               },
  //             ),),
  //             Padding(
  //             padding:
  //                 const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
  //             child: TextFormField(
  //               controller: _usuarioController,
  //               autofocus: false,
  //               keyboardType: TextInputType.text,
  //               style: Theme.of(context).textTheme.headline1,
  //               cursorColor: Theme.of(context).primaryColorDark,
  //               cursorWidth: 4,
  //               decoration: InputDecoration(
  //                 hintText: 'Usuario',
  //                 hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
  //                     color:
  //                         Theme.of(context).primaryColorDark.withOpacity(0.2)),
  //                 focusedBorder: InputBorder.none,
  //                 border: InputBorder.none,
  //                 errorBorder: InputBorder.none,
  //                 enabledBorder: InputBorder.none,
  //                 disabledBorder: InputBorder.none,
  //                 focusedErrorBorder: InputBorder.none,
  //               ),
  //               validator: (value) {
  //                 if (value!.isEmpty) {
  //                   return 'Debes ingresar un nombre para continuar';
  //                 } else {
  //                   return null;
  //                 }
  //               },
  //             ),
              
  //           ),
  //           SizedBox(height: 60),
  //           Padding(
  //             padding: const EdgeInsets.all(40.0),
  //             child: InkWell(
  //                 onTap: () async {
  //                   setState(() {
  //                         // _deleteAvioncitoUsuario(widget.id);
  //                         _deleteAvioncitoUsuario(widget.id);
  //                         _construirNuevoAvioncito();
  //                         _fraseController.clear();
  //                         _santoController.clear();
  //                         _reflexionController.clear();
  //                         _tagController.clear();
  //                         _usuarioController.clear();
  //                         Navigator.of(context).pop();
  //                       });
  //                 },
  //                 child: Text(
  //                   'Confirmar',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .headline1!
  //                       .copyWith(color: Theme.of(context).colorScheme.secondary),
  //                 ),
  //               )
  //               ),
            
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _construirNuevoAvioncito() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference avioncitoRef = _db.collection('datosApp').doc();

    avioncitoRef.set({
      'frase': _fraseController.text,
      'santo': _santoController.text,
      'reflexion': _reflexionController.text,
      'tag': _tagController.text,
      'usuario': _usuarioController.text,
    });
  }

  void _deleteAvioncitoUsuario(String? id) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference avioncitoRef = _db.collection('datosUsuarios').doc(id);
    print('avioncito ${avioncitoRef.id} eliminado de datosUsuarios');
    avioncitoRef.delete();
  }
}