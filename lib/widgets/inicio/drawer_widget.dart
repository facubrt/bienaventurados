import 'package:bienaventurados/data/local/drawer_items.dart';
import 'package:bienaventurados/models/drawer_item_model.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final ValueChanged<DrawerItemModel> onSelectedItem;

  const DrawerWidget({Key? key, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30),
            child: Text('Bien\naven\ntura\ndos',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.16,
              )
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          buildDrawerItems(context),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Text(
            '\u00a9 ${DateTime.now().year} Ser Eucaristía'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.028,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: DrawerItems.paginas.map(
        (pagina) {
          if(pagina.titulo != 'Division') {
            return ListTile(
            contentPadding: EdgeInsets.only(left: 30),
            leading: Icon(pagina.icon, size: 22, color: Theme.of(context).primaryColorDark),
            title: Text(
              pagina.titulo,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            onTap: () => onSelectedItem(pagina),
          );
        } else {
          return Divider(indent: 30, endIndent: MediaQuery.of(context).size.width * 0.4, color: Theme.of(context).primaryColorDark);
        }
        }
      ).toList(),
    );
  }
}
