import 'package:bienaventurados/data/local/drawer_items.dart';
import 'package:bienaventurados/models/drawer_item_model.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {

  final ValueChanged<DrawerItemModel> onSelectedItem;

  const DrawerWidget({Key? key, required this.onSelectedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bien\naven\ntura\ndos',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 68)),
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            buildDrawerItems(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Text(
            'Carlo Acutis (beato) versión 1.1.0'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 12,
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
        (pagina) => Column(
          children: [
            InkWell(
              onTap: () => onSelectedItem(pagina),
              child: Text(
                pagina.titulo,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(height:40),
          ],
        ),).toList(),
    );
  }
}
