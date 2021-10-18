import 'package:bienaventurados/data/local/meses.dart';
import 'package:bienaventurados/models/guardados_model.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
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
                Guardados? guardado = box.getAt(index);
                return InkWell(
                  onTap: () {
                    print('abrir');
                    Navigator.of(context).pushNamed(compartirPage);
                  },
                  child: avioncitoCarta(
                    context,
                    guardado!.frase,
                    guardado.santo,
                    guardado.reflexion,
                    guardado.tag,
                    guardado.fecha,
                  ),
                );
              }
          );
        },
      )
      
    );
  }

  Widget avioncitoCarta(BuildContext context, String? frase, String? santo, String? reflexion, String? tag, DateTime? fecha) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              frase!,
              style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 10,
          ),
          Text(
            santo!,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text('${fecha!.day} de ${Meses.meses[fecha.month-1].id}, ${fecha.year}'.toUpperCase(), style:Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12,),),
              Spacer(),
              Text('Eliminar'.toUpperCase(), style:Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12,),)
            ],
          ),
        ],
      ),
    );
  }
}