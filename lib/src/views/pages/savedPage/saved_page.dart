import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/data/local/months_data.dart';
import 'package:bienaventurados/src/models/avioncito_model.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    final drawerProvider = Provider.of<DrawerProvider>(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              drawerProvider.openDrawer();
            },
            icon: Icon(Iconsax.category,
                size: MediaQuery.of(context).size.width * 0.06),
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: ValueListenableBuilder(
              valueListenable:
                  paperplaneProvider.getSavedFromLocal().listenable(),
              builder: (BuildContext context, Box box, _) {
                if (box.values.isEmpty) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Iconsax.save_2,
                              color: Theme.of(context).primaryColorDark,
                              size: MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.08),
                        Text(
                          SAVED_PAGE_TITLE,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                fontSize: MediaQuery.of(context).size.width *
                                    SCALE_H3,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Text(
                          SAVED_PAGE_TEXT,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                fontSize: MediaQuery.of(context).size.width *
                                    SCALE_H4,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ));
                }
                return ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0,
                        indent: MediaQuery.of(context).size.width * 0.08,
                        endIndent: MediaQuery.of(context).size.width * 0.08,
                        color: Theme.of(context).primaryColorDark,
                      );
                    },
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Avioncito savedPaperplane = box.getAt(index);

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(paperplanePage,
                              arguments: savedPaperplane);
                        },
                        child: cardPaperplane(
                          context,
                          savedPaperplane,
                        ),
                      );
                    });
              },
            )));
  }

  Widget cardPaperplane(BuildContext context, Avioncito savedPaperplane) {
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    return Padding(
      padding:
          const EdgeInsets.only(left: 30.0, right: 30, top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(savedPaperplane.frase!,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                  )),
          SizedBox(
            height: 10,
          ),
          Text(
            savedPaperplane.santo!,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * SCALE_H4,
                ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                '${savedPaperplane.fecha!.day} de ${Months.allMonths[savedPaperplane.fecha!.month - 1].id}, ${savedPaperplane.fecha!.year}'
                    .toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  paperplaneProvider.dontSavePaperplane(savedPaperplane);
                },
                icon: Icon(Iconsax.archive_slash,
                    size: MediaQuery.of(context).size.width * 0.06,
                    color: Theme.of(context).primaryColorDark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
