import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late int _imgProfile;
  late String? name;

  List images = [
    'perfil-01',
    'perfil-02',
    'perfil-03',
    'perfil-04',
    'perfil-05',
  ];

  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferences();
    final authProvider = Provider.of<AuthProvider>(context);
    name = authProvider.user.nombre;
    // final authProvider = Provider.of<AuthProvider>(context);
    _imgProfile = prefs.imgProfile;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                if (_imgProfile < (images.length - 1)) {
                  _imgProfile += 1;
                } else {
                  _imgProfile = 0;
                }
                prefs.imgProfile = _imgProfile;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.width * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(18),
              //     border: Border.all(
              //         width: 4, color: Theme.of(context).primaryColorDark)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/perfil/${images[_imgProfile]}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.06,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                        ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    BIENAVENTURADO_SEAS,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  //nivelWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget levelWidget() {
    final widthExperience = MediaQuery.of(context).size.width - 300;
    final experience = widthExperience / 2;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nivel 3', 
          style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                    ),
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.secondary),
                    height: 10,
                    width: experience,
                  ),
                ]),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '128 / 500',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              )
            ],
          ),
        ],
    );
  }
}
