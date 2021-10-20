import 'package:bienaventurados/data/local/meses.dart';
import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class GuardadosPage extends StatefulWidget {
  const GuardadosPage({ Key? key }) : super(key: key);

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
      appBar: AppBar(
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: avioncitoProvider.getGuardadosFromLocal().listenable(),
        builder: (BuildContext context, Box box, _) {
          if(box.values.isEmpty) {
            return Center(child: Text('Aún no has capturado ningún avioncito.'));
          }
          return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Avioncito avioncitoGuardado = box.getAt(index);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(redescubrePage, arguments: avioncitoGuardado);
                  },
                  child: avioncitoCarta(
                    context,
                    avioncitoGuardado,
                  ),
                );
              }
          );
        },
      )
      
    );
  }

  Widget avioncitoCarta(BuildContext context, Avioncito avioncitoGuardado) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              avioncitoGuardado.frase!,
              style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 10,
          ),
          Text(
            avioncitoGuardado.santo!,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text('${avioncitoGuardado.fecha!.day} de ${Meses.meses[avioncitoGuardado.fecha!.month-1].id}, ${avioncitoGuardado.fecha!.year}'.toUpperCase(), style:Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12,),),
              Spacer(),
              IconButton(
                onPressed: () {
                  avioncitoProvider.noGuardarAvioncito(avioncitoGuardado.id!);
                },
                icon: Icon(
                  FlutterIcons.bookmark_mco,
                  size: 22,
                  color: Theme.of(context).primaryColorDark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}