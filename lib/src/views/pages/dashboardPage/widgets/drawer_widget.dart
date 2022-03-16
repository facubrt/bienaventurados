import 'package:bienaventurados/src/data/local/drawer_items.dart';
import 'package:bienaventurados/src/models/drawer_item_model.dart';
import 'package:bienaventurados/src/constants/constants.dart';
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
            child: Text(DASHBOARD_HEADER,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: MediaQuery.of(context).size.width * SCALE_H1,
              )
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * SPACE_HEADER),
          buildDrawerItems(context),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Text(
            copyright,
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
      children: DrawerItems.allPages.map(
        (page) {
          if(page.title != 'Division') {
            return ListTile(
            contentPadding: EdgeInsets.only(left: 30),
            leading: Icon(page.icon, size: 22, color: Theme.of(context).primaryColorDark),
            title: Text(
              page.title,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            onTap: () => onSelectedItem(page),
          );
        } else {
          return Divider(indent: 30, endIndent: MediaQuery.of(context).size.width * 0.4, color: Theme.of(context).primaryColorDark);
        }
        }
      ).toList(),
    );
  }
}
