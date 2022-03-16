import 'package:bienaventurados/src/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String? quote;
  final String? saint;
  final String? reflexion;
  final String? tag;
  final String? user;
  final String? id;

  const EditPage({ Key? key, required this.quote, required this.saint, required this.reflexion, required this.tag, required this.user, required this.id }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _saintController = TextEditingController();
  final TextEditingController _reflexionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _missionController = TextEditingController();
  final quoteFormKey = GlobalKey<FormState>();
  final reflexionFormKey = GlobalKey<FormState>();
  final questionFormKey = GlobalKey<FormState>();

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _quoteController.text = widget.quote as String;
    _saintController.text = widget.saint as String;
    _reflexionController.text = widget.reflexion as String;
    _tagController.text = widget.tag as String;
    _userController.text = widget.user as String;
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
          quoteWidget(),
          reflexionWidget(),
          questionWidget(),
          finishWidget(),
        ],
      ),
    );
  }

  Widget quoteWidget() {
    return Form(
      key: quoteFormKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(QUOTE_WIDGET_TITLE,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _quoteController,
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
                    hintText: QUOTE_HINT,
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
                      return QUOTE_EMPTY_ERROR;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
                TextFormField(
                  controller: _saintController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: SAINT_HINT,
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
                      return SAINT_EMPTY_ERROR;
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
                if (quoteFormKey.currentState!.validate()) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 1200),
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

  Widget reflexionWidget() {
    return Form(
      key: reflexionFormKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(REFLEXION_WIDGET_TITLE,
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
                    hintText: REFLEXION_HINT,
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
                      return REFLEXION_EMPTY_ERROR;
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
                    hintText: TAG_HINT,
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
                      return TAG_EMPTY_ERROR;
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

  Widget questionWidget() {
    return Form(
      key: questionFormKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(QUESTION_WIDGET_TITLE,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _questionController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: QUESTION_HINT,
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
                  controller: _missionController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: MISSION_HINT,
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
                if (questionFormKey.currentState!.validate()) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    _buildPaperplane();
                    _deleteUserData(widget.id);
                    _quoteController.clear();
                    _saintController.clear();
                    _reflexionController.clear();
                    _tagController.clear();
                    _questionController.clear();
                    _missionController.clear();
                  });
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 1200),
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

  Widget finishWidget() {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Text(
            FINISH_WIDGET_TITLE,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
          child: Text(
              FINISH_WIDGET_TEXT,
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
            child: Text(FINISH_BUTTON,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Theme.of(context).primaryColor)),
          ),
        ),
      ),
    );
  }

  void _buildPaperplane() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference avioncitoRef = _db.collection(COLLECTION_USERDATA).doc();

    // TODO cambiar a inglés (posiblemente requiera migracion)
    avioncitoRef.set({
      'frase': _quoteController.text,
      'santo': _saintController.text,
      'reflexion': _reflexionController.text,
      'tag': _tagController.text,
      'usuario': _userController.text,
    });
  }

  void _deleteUserData(String? id) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference paperplaneRef = _db.collection(COLLECTION_USERDATA).doc(id);
    paperplaneRef.delete();
  }
}