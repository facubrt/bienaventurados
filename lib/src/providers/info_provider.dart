// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

// class InfoProvider with ChangeNotifier {
//   int _avCompartidos = 0;
//   final FirebaseFirestore _fireDB = FirebaseFirestore.instance;

//   void actualizarInformacionApp(String accion) {
//     getInfoFromFirestore().then((listo) {
//       updateInfoApp(accion);
//     });
//   }

//   void cargarInfoApp() {
//     getInfoFromFirestore();
//   }

//   Future<bool> getInfoFromFirestore() async {
//     DocumentReference infoRef =
//         _fireDB.collection('infoApp').doc('infoAvioncitos');
//     DocumentSnapshot infoData = await infoRef.get();
//     _avCompartidos = infoData['av-compartidos'];
//     print('SE COMPARTIERON $_avCompartidos avioncitos hoy');
//     return true;
//   }

//   Future<bool> updateInfoApp(String accion) async {
//     DocumentReference userRef =
//         _fireDB.collection('infoApp').doc('infoAvioncitos');

//     if (accion == 'aumentar') {
//       _avCompartidos += 1;
//       await userRef.set({
//         'av-compartidos': _avCompartidos,
//       }, SetOptions(merge: true));
//     } else if (accion == 'restaurar' && _avCompartidos != 0) {
//       print('RESTAURANDO CONTADOR');
//       _avCompartidos -= 1;
//       await userRef.set({
//         'av-compartidos': 0,
//       }, SetOptions(merge: true));
//     }
//     print('SE COMPARTIERON $_avCompartidos avioncitos hoy');
//     //_avCompartidos = await userRef.get('av-compartidos');

//     return true;
//   }

//   int get avCompartidos => _avCompartidos;
// }
