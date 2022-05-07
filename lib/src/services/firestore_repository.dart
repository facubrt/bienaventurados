import 'package:bienaventurados/src/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  

  Future<DocumentSnapshot> cargarDatosUsuario(String uid) async {
    DocumentSnapshot userSnap = await _db.collection(COLLECTION_USERS).doc(uid).get();
    return userSnap;
  }
}