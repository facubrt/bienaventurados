import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ConstruirPage extends StatefulWidget {
  const ConstruirPage({
    Key? key,
  }) : super(key: key);

  @override
  _ConstruirPageState createState() => _ConstruirPageState();
}

class _ConstruirPageState extends State<ConstruirPage> {
  final TextEditingController _fraseController = TextEditingController();
  final TextEditingController _santoController = TextEditingController();
  final TextEditingController _reflexionController = TextEditingController();
  final fraseFormKey = GlobalKey<FormState>();
  final reflexionFormKey = GlobalKey<FormState>();
  final preguntaFormKey = GlobalKey<FormState>();
  String tag = 'Oración';

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    return Scaffold(
      backgroundColor: drawerProvider.isDrawerOpen ? Colors.transparent : Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            drawerProvider.openDrawer();
          },
          icon: Icon(Iconsax.category, size: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          fraseWidget(),
          reflexionWidget(),
          tagWidget(),
          avioncitoListoWidget(),
        ],
      ),
    );
  }

  void _construirNuevoAvioncito(String? usuario) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference avioncitoRef = _db.collection('datosUsuarios').doc();

    avioncitoRef.set({
      'frase': _fraseController.text,
      'santo': _santoController.text,
      'reflexion': _reflexionController.text,
      'tag': tag,
      'pregunta': '',
      'mision': '',
      'usuario': usuario,
    });
  }

  Widget fraseWidget() {
    return Form(
      key: fraseFormKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
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
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Página 1 de 3',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    if (fraseFormKey.currentState!.validate()) {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      _pageController.nextPage(duration: Duration(milliseconds: 1200), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Text('Siguiente',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: MediaQuery.of(context).size.width * 0.04, color: Theme.of(context).primaryColor)),
                ),
              ),
            ],
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
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Página 2 de 3',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    if (reflexionFormKey.currentState!.validate()) {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      _pageController.nextPage(duration: Duration(milliseconds: 1200), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Text(
                    'Siguiente',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: MediaQuery.of(context).size.width * 0.04, color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tagWidget() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text('¡Casi está listo! Selecciona una categoría para tu avioncito',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              buildChoiceChip(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Página 3 de 3',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
            Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                 
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    setState(() {
                      _construirNuevoAvioncito(authProvider.usuario.nombre);
                      _fraseController.clear();
                      _santoController.clear();
                      _reflexionController.clear();
                    });
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 1200),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                child: Text('Siguiente',
                    style:
                        Theme.of(context).textTheme.headline4!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.04, color: Theme.of(context).primaryColor),),
              ),
            ),
          ],
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
          child: Text('Tu avioncito está terminado y pronto empezará a volar por los corazones de todos en Bienaventurados.\n\n¡Muchas gracias por construir!',
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
              Navigator.of(context).pushNamed(dashboardPage);
              final logroProvider = Provider.of<LogroProvider>(context, listen: false);
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              logroProvider.comprobacionLogros('construidos');
              authProvider.actualizarConstruidos();
            },
            child: Text('Finalizar',
                style:
                    Theme.of(context).textTheme.headline4!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.04, color: Theme.of(context).primaryColor)),
          ),
        ),
      ),
    );
  }

  Widget buildChoiceChip() {
    return Wrap(
      runSpacing: MediaQuery.of(context).size.width * 0.01,
      spacing: MediaQuery.of(context).size.width * 0.04,
      children: [
        ChoiceChip(
          label: Text('Oración',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == 'Oración' ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
                  )),
          selected: tag == 'Oración' ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = 'Oración';
            });
          },
        ),
        ChoiceChip(
          label: Text('Acción',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == 'Acción' ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
                  )),
          selected: tag == 'Acción' ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = 'Acción';
            });
          },
        ),
        ChoiceChip(
          label: Text('Formación',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == 'Formación' ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark
                  )),
          selected: tag == 'Formación' ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = 'Formación';
            });
          },
        ),
        ChoiceChip(
          label: Text('Entrega',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == 'Entrega' ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark
                  )),
          selected: tag == 'Entrega' ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = 'Entrega';
            });
          },
        ),
        ChoiceChip(
          label: Text('Santidad',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == 'Santidad' ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark
                  )),
          selected: tag == 'Santidad' ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = 'Santidad';
            });
          },
        ),
        ChoiceChip(
          label: Text('Amor',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == 'Amor' ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark
                  )),
          selected: tag == 'Amor' ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = 'Amor';
            });
          },
        ),
        ChoiceChip(
          label: Text('Reflexión',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == 'Reflexión' ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark
                  )),
          selected: tag == 'Reflexión' ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = 'Reflexión';
            });
          },
        )
      ],
    );
  }
}
