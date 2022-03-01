import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/logic/providers/providers.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

class ConfiguracionesPage extends StatefulWidget {
  const ConfiguracionesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionesPage> createState() => _ConfiguracionesPageState();
}

class _ConfiguracionesPageState extends State<ConfiguracionesPage> {
  late SharedPreferences prefs;
  final InAppReview inAppReview = InAppReview.instance;
  late PackageInfo packageInfo;
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  final _listaOpciones = [
    'General',
    'Cuenta',
    //'Legal',
    'Salir',
  ];

  @override
  void initState() {
    super.initState();
    getPackageInfo();
  }

  void getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          icon: Icon(Iconsax.category, size: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
      body: ListView.separated(
          itemCount: _listaOpciones.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: MediaQuery.of(context).size.width * 0.04),
              onTap: () {
                navegarHacia(index);
              },
              title: Text(_listaOpciones[index],
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 0,
              indent: MediaQuery.of(context).size.width * 0.08,
              endIndent: MediaQuery.of(context).size.width * 0.08,
              color: Theme.of(context).primaryColorDark,
            );
          }),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: versionInfoWidget(),
        ),
      ),
    );
  }

  Future<void> navegarHacia(int pagina) async {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();
    switch (_listaOpciones[pagina]) {
      case 'General':
        Navigator.of(context).pushNamed(generalConfiguracionPage);
        break;
      case 'Cuenta':
        Navigator.of(context).pushNamed(cuentaConfiguracionPage);
        break;
      case 'Legal':
        Navigator.of(context).pushNamed(legalConfiguracionPage);
        break;
      case 'Salir':
        showFloatingModalBottomSheet(
          backgroundColor: Theme.of(context).primaryColor,
          context: context,
          builder: (context) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Iconsax.close_square,
                          size: MediaQuery.of(context).size.width * 0.06,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('¿Descansar de esta aventura?',
                        style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.06)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Tener un tiempo de tranquilidad, un tiempo para estar solo y escuchar al corazón es tan importante como el mantenerse en movimiento. \n\n¡Paz y Bien!',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  InkWell(
                    onTap: () {
                      avioncitoProvider.eliminarDB();
                      authProvider.signOut();
                      prefs.limpiarPrefs();
                      prefs.modoNoche = false;
                      Navigator.of(context).pushNamedAndRemoveUntil(bienaventuradosPage, (route) => false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('Salir',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: MediaQuery.of(context).size.width * 0.03, color: Theme.of(context).primaryColorDark)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        break;
      default:
        break;
    }
  }

  Widget versionInfoWidget() {
    return Text(
      '$appName $version + $buildNumber'.toUpperCase(),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.028,
          ),
      textAlign: TextAlign.center,
    );
  }
}
