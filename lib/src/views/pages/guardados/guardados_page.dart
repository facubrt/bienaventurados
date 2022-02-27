import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class GuardadosPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const GuardadosPage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<GuardadosPage> createState() => _GuardadosPageState();
}

class _GuardadosPageState extends State<GuardadosPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              widget.openDrawer();
            },
            icon: Icon(Iconsax.category, size: 22),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: avioncitoProvider.getGuardadosFromLocal().listenable(),
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
                        color: Theme.of(context).primaryColorDark.withOpacity(0.1),
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
                    SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                    Text(
                      'Tus avioncitos guardados',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.06,
                    ),
                    Text(
                      'Aún no has guardado ningún avioncito. Colecciona tus favoritos y visitalos más tarde para redescubrir su mensaje con un corazón renovado.',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
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
                  Avioncito avioncitoGuardado = box.getAt(index);

                  return InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed(avioncitoPage, arguments: avioncitoGuardado);
                      Navigator.of(context).pushNamed(avioncitoPage, arguments: avioncitoGuardado);
                    },
                    child: avioncitoCarta(
                      context,
                      avioncitoGuardado,
                    ),
                  );
                });
          },
        ));
  }

  Widget avioncitoCarta(BuildContext context, Avioncito avioncitoGuardado) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(avioncitoGuardado.frase!,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  )),
          SizedBox(
            height: 10,
          ),
          Text(
            avioncitoGuardado.santo!,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
            textAlign: TextAlign.end,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                '${avioncitoGuardado.fecha!.day} de ${MesesData.meses[avioncitoGuardado.fecha!.month - 1].id}, ${avioncitoGuardado.fecha!.year}'.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  avioncitoProvider.noGuardarAvioncito(avioncitoGuardado);
                },
                icon: Icon(Iconsax.archive_slash, size: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
