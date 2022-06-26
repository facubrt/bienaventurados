import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  _BuildPageState createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _saintController = TextEditingController();
  final TextEditingController _reflexionController = TextEditingController();
  final quoteFormKey = GlobalKey<FormState>();
  final reflexionFormKey = GlobalKey<FormState>();
  final questionFormKey = GlobalKey<FormState>();
  String tag = PRAYER_CHIP;

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
      backgroundColor: drawerProvider.isDrawerOpen
          ? Colors.transparent
          : Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            drawerProvider.openDrawer();
          },
          icon: Icon(Iconsax.category,
              size: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          quoteWidget(),
          reflexionWidget(),
          tagWidget(),
          finishWidget(),
        ],
      ),
    );
  }

  Widget quoteWidget() {
    return Form(
      key: quoteFormKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  minLines: 1,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: QUOTE_HINT,
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
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
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: SAINT_HINT,
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
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
                    if (quoteFormKey.currentState!.validate()) {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
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
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  minLines: 1,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: REFLEXION_HINT,
                    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3,
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
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 1200),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Text(
                    CONTINUE_BUTTON,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Theme.of(context).primaryColor),
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
    final paperplaneProvider =
        Provider.of<PaperplaneProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(TAG_WIDGET_TITLE,
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
                    // SE CREA AVIONCITO EN BASE DE DATOS USERSDATA
                    paperplaneProvider.buildPaperplaneUsersData(
                        _quoteController.text,
                        _saintController.text,
                        _reflexionController.text,
                        tag,
                        authProvider.user.username!);
                    _quoteController.clear();
                    _saintController.clear();
                    _reflexionController.clear();
                  });
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 1200),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                child: Text(
                  CONTINUE_BUTTON,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
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
          child: Text(FINISH_WIDGET_TEXT,
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
              final logroProvider =
                  Provider.of<AchievementProvider>(context, listen: false);
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              logroProvider.achievementsCheck(ACHIEVEMENT_BUILDED);
              authProvider.updatePaperplanesBuilded();
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

  Widget buildChoiceChip() {
    return Wrap(
      runSpacing: MediaQuery.of(context).size.width * 0.01,
      spacing: MediaQuery.of(context).size.width * 0.04,
      children: [
        ChoiceChip(
          label: Text(PRAYER_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == PRAYER_CHIP
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark,
                  )),
          selected: tag == PRAYER_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = PRAYER_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(ACTION_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == ACTION_CHIP
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark,
                  )),
          selected: tag == ACTION_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = ACTION_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(MARY_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == MARY_CHIP
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark,
                  )),
          selected: tag == MARY_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = MARY_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(BIBLE_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == BIBLE_CHIP
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark,
                  )),
          selected: tag == BIBLE_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = BIBLE_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(FAITH_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    color: tag == FAITH_CHIP
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark,
                  )),
          selected: tag == FAITH_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = FAITH_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(FORMATION_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                  color: tag == FORMATION_CHIP
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark)),
          selected: tag == FORMATION_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = FORMATION_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(DEVOTION_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                  color: tag == DEVOTION_CHIP
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark)),
          selected: tag == DEVOTION_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = DEVOTION_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(HOLINESS_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                  color: tag == HOLINESS_CHIP
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark)),
          selected: tag == HOLINESS_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = HOLINESS_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(LOVE_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                  color: tag == LOVE_CHIP
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark)),
          selected: tag == LOVE_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = LOVE_CHIP;
            });
          },
        ),
        ChoiceChip(
          label: Text(REFLEXION_CHIP,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                  color: tag == REFLEXION_CHIP
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark)),
          selected: tag == REFLEXION_CHIP ? true : false,
          onSelected: (selected) {
            setState(() {
              tag = REFLEXION_CHIP;
            });
          },
        )
      ],
    );
  }
}
