import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TallerPage extends StatefulWidget {
  const TallerPage({Key? key}) : super(key: key);

  @override
  _TallerPageState createState() => _TallerPageState();
}

class _TallerPageState extends State<TallerPage> {

  final Stream<QuerySnapshot> avioncitos = FirebaseFirestore.instance.collection('datosUsuarios').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: avioncitos,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError) {
            return Text('¡Oh, oh! Algo ha salido mal. Intentalo de nuevo más tarde');
          } 
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Cargando avioncitos...'));
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
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColorDark.withOpacity(0.1),),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(FlutterIcons.inbox_fea, color: Theme.of(context).primaryColorDark),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text('Tus avioncitos por construir', style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center,),
                  SizedBox(height: 20),
                  Text('Aún no hay avioncitos para hacer volar. Los avioncitos que se construyan llegarán hasta acá para tomar vuelo y comenzar su aventura.', style: Theme.of(context).textTheme.bodyText2, textAlign: TextAlign.center),
                ],
            ),
              ));
          }
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(height: 40,);
              },
              itemCount: data.size,
              itemBuilder: (context, index) {
                return avioncitoCarta(data.docs[index].id, data.docs[index]['frase'], data.docs[index]['santo'], data.docs[index]['reflexion'], data.docs[index]['usuario'], data.docs[index]['tag']);
              }
            ),
          );
        },
      )
    );
  }

  Widget avioncitoCarta(String id, String frase, String santo, String reflexion, String usuario, String tag) {
    Avioncito avioncito = Avioncito(id: id, frase: frase, santo: santo, reflexion: reflexion, tag: tag, usuario: usuario);
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                frase,
                style: Theme.of(context).textTheme.headline4),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                santo,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Theme.of(context).primaryColorDark),
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
            SizedBox(height: 20,),
            Row(
              children: [
                Text(usuario, style:Theme.of(context).textTheme.subtitle1),
                Spacer(),
                IconButton(
                onPressed: () {
                  // _deleteAvioncitoUsuario(avioncito.id);
                  Navigator.of(context).pushNamed(editarPage, arguments: avioncito);
                },
                icon: Icon(
                  FlutterIcons.check_fea,
                  size: 22,
                  color: Theme.of(context).colorScheme.secondary),
              ),
                
                SizedBox(width: 10,),
                IconButton(
                onPressed: () {
                  _deleteAvioncitoUsuario(avioncito.id);
                },
                icon: Icon(
                  FlutterIcons.x_fea,
                  size: 22,
                  color: Theme.of(context).primaryColorDark),
              ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _deleteAvioncitoUsuario(String? id) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference avioncitoRef = _db.collection('datosUsuarios').doc(id);
    print('avioncito ${avioncitoRef.id} eliminado de datosUsuarios');
    avioncitoRef.delete();
  }
}
