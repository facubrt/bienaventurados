import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/models/paperplane_model.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GaragePage extends StatefulWidget {
  const GaragePage({Key? key}) : super(key: key);

  @override
  _GaragePageState createState() => _GaragePageState();
}

class _GaragePageState extends State<GaragePage> {
  final Stream<QuerySnapshot> paperplanes = FirebaseFirestore.instance
      .collection(COLLECTION_USERSDATA)
      .doc(COLLECTION_USERSDATA_PPLANESBUILDED)
      .collection(COLLECTION_USERSDATA_PPLANESBUILDED_PPLANES)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          //title: Text('Taller'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: paperplanes,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(ERROR_TEXT);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text(LOADING_TEXT));
            }
            final data = snapshot.requireData;
            if (data.size == 0) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Iconsax.direct_normal,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      STUDIO_PAGE_TITLE,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(STUDIO_PAGE_TEXT,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center),
                  ],
                ),
              ));
            }
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 40,
                    );
                  },
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return cardPaperplane(
                        data.docs[index].id,
                        data.docs[index]['quote'],
                        data.docs[index]['source'],
                        data.docs[index]['inspiration'],
                        data.docs[index]['user'],
                        data.docs[index]['category']);
                  }),
            );
          },
        ));
  }

  Widget cardPaperplane(String id, String quote, String saint, String reflexion,
      String user, String tag) {
    Paperplane paperplane = Paperplane(
        id: id,
        quote: quote,
        source: saint,
        inspiration: reflexion,
        category: tag,
        user: user);
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quote, style: Theme.of(context).textTheme.headline4),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                saint,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).primaryColorDark),
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              reflexion,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(user, style: Theme.of(context).textTheme.subtitle1),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(editPage, arguments: paperplane);
                  },
                  icon: Icon(Iconsax.tick_square,
                      size: MediaQuery.of(context).size.width * DIMENSION_ICON,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                IconButton(
                  onPressed: () {
                    _deletePaperplaneUser(paperplane.id);
                  },
                  icon: Icon(Iconsax.close_square,
                      size: MediaQuery.of(context).size.width * DIMENSION_ICON,
                      color: Theme.of(context).primaryColorDark),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _deletePaperplaneUser(String? id) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference paperplaneRef = _db
        .collection(COLLECTION_USERSDATA)
        .doc(COLLECTION_USERSDATA_PPLANESBUILDED)
        .collection(COLLECTION_USERSDATA_PPLANESBUILDED_PPLANES)
        .doc(id);
    paperplaneRef.delete();
  }
}
