import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final passwordFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  late bool hidePassword;

  final PageController _pageController = PageController(initialPage: 0);

  // Boton de carga
  int _state = 0;

  @override
  void initState() {
    super.initState();
    hidePassword = true;
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //title: Text('Comenzar aventura'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Iconsax.arrow_left,
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          emailPage(),
          passwordPage(),
          namePage(),
        ],
      ),
    );
  }

  Widget emailPage() {
    return Form(
      key: emailFormKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(EMAIL_INPUT,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              TextFormField(
                controller: emailController,
                autofocus: false,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * SCALE_H4,
                    ),
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: EMAIL_HINT,
                  hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * SCALE_H4,
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
                  if (!value!.contains('@')) {
                    return EMAIL_ERROR;
                  } else {
                    return null;
                  }
                },
              ),
            ],
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
                if (emailFormKey.currentState!.validate()) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.fastLinearToSlowEaseIn);
                }
              },
              child: Text(CONTINUE_BUTTON,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordPage() {
    return Form(
      key: passwordFormKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(PASSWORD_INPUT,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              TextFormField(
                  controller: passwordController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H4,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: hidePassword
                            ? Icon(
                                Iconsax.eye_slash,
                                size: MediaQuery.of(context).size.width * 0.06,
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2),
                              )
                            : Icon(
                                Iconsax.eye,
                                size: MediaQuery.of(context).size.width * 0.06,
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2),
                              )),
                    hintText: PASSWORD_HINT,
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H4,
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
                      return PASSWORD_EMPTY_ERROR;
                    } else if (value.length < 8) {
                      return PASSWORD_LENGTH_ERROR;
                    } else {
                      return null;
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    recoverAccount();
                  },
                  child: Text(FORGOT_YOUR_PASSWORD),
                ),
              )
            ],
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
                child: setUpButtonChild(),
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (passwordFormKey.currentState!.validate()) {
                    setState(() {
                      if (_state == 0) {
                        _state = 1;
                        signIn();
                      }
                    });
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget namePage() {
    return Form(
      key: nameFormKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(NAME_INPUT,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              TextFormField(
                controller: nameController,
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * SCALE_H4,
                    ),
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: NAME_HINT,
                  hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * SCALE_H4,
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
                    return NAME_ERROR;
                  } else {
                    return null;
                  }
                },
              ),
            ],
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
                if (nameFormKey.currentState!.validate()) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (nameFormKey.currentState!.validate()) {
                    setState(() {
                      if (_state == 0) {
                        _state = 1;
                        signUp();
                      }
                    });
                  }
                }
              },
              child: setUpButtonChild(),
            ),
          ),
        ),
      ),
    );
  }

  // BOTON DE CARGA
  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        CONTINUE_BUTTON,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ));
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void recoverAccount() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
            '¡No te preocupes! Hemos enviado un correo a ${emailController.text} para que puedas restablecer tu contraseña.',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );
    authProvider.restorePassword(emailController.text);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void signIn() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = UserPreferences();

    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(SIGN_IN_ERROR,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );

    authProvider
        .signInWithEmailAndPassword(
            emailController.text, passwordController.text)
        .then((result) {
      if (result == USER_FOUND_MESSAGE) {
        prefs.isLoggedIn = true;
        Navigator.of(context)
            .pushNamedAndRemoveUntil(dashboardPage, (route) => false);
      } else if (result == WRONG_PASSWORD_MESSAGE) {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        setState(() {
          _state = 0;
        });
      } else if (result == INVALID_EMAIL_MESSAGE) {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        setState(() {
          _state = 0;
        });
      } else if (result == USER_NOT_FOUND_MESSAGE) {
        setState(() {
          _state = 0;
        });
        _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.fastLinearToSlowEaseIn);
      }
    });
  }

  void signUp() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = UserPreferences();

    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(SIGN_IN_ERROR,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );

    authProvider
        .createUserWithEmailAndPassword(
            nameController.text, emailController.text, passwordController.text)
        .then((result) {
      if (result != null) {
        prefs.isLoggedIn = true;
        Navigator.of(context)
            .pushNamedAndRemoveUntil(dashboardPage, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    });
  }
}
