import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        title: Text('Taller de avioncitos'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: avioncitos,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError) {
            return Text('¡Oh, oh! Algo ha salido mal. Intentalo de nuevo más tarde');
          } 
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Cargando avioncitos...');
          }
          final data = snapshot.requireData;

          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(height: 40,);
              },
              itemCount: data.size,
              itemBuilder: (context, index) {
                return avioncitoCarta(data.docs[index]['frase'], data.docs[index]['santo'], data.docs[index]['reflexion'], data.docs[index]['usuario'], data.docs[index]['tag']);
              }
            ),
          );
        },
      )
    );
  }

  Widget avioncitoCarta(String frase, String santo, String reflexion, String usuario, String tag) {
    Avioncito avioncito = Avioncito(frase: frase, santo: santo, reflexion: reflexion, tag: tag);
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                frase,
                style: Theme.of(context).textTheme.headline2),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                santo,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              reflexion,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text(usuario, style:Theme.of(context).textTheme.subtitle1),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(editarPage, arguments: avioncito);
                  },
                  child: Text('Aceptar', style:Theme.of(context).textTheme.subtitle1),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: () {},
                  child: Text('Rechazar', style:Theme.of(context).textTheme.subtitle1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
