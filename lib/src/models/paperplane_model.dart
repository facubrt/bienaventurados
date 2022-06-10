// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// part 'paperplane_model.g.dart';

// @HiveType(typeId: 0)
// class Paperplane extends HiveObject with ChangeNotifier {
//   @HiveField(0)
//   String? id;
//   @HiveField(1)
//   DateTime? date;
//   @HiveField(2)
//   String? quote;
//   @HiveField(3)
//   String? source;
//   @HiveField(4)
//   String? inspiration;
//   @HiveField(5)
//   String? category;
//   @HiveField(8)
//   String? user;
//   // ILLUSTRATION
//   @HiveField(9)
//   String? background;
//   @HiveField(10)
//   String? base;
//   @HiveField(11)
//   String? detail;
//   @HiveField(12)
//   String? pattern;
//   @HiveField(13)
//   String? stamp;
//   @HiveField(14)
//   String? wings;
//   // INTERACTION
//   @HiveField(15)
//   int? likes;
//   @HiveField(16)
//   bool? saved;

//   Paperplane({
//     this.id,
//     this.date,
//     this.quote,
//     this.source,
//     this.inspiration,
//     this.category,
//     this.user,
//     this.background,
//     this.base,
//     this.detail,
//     this.pattern,
//     this.stamp,
//     this.wings,
//     this.likes,
//     this.saved,
//   });

//   factory Paperplane.fromFirestore(DocumentSnapshot paperplaneDoc) {
//     Map paperplaneData = paperplaneDoc.data()! as Map;
//     return Paperplane(
//       id: paperplaneDoc.id,
//       date: DateTime.now(),
//       quote: paperplaneData['quote'],
//       source: paperplaneData['source'],
//       inspiration: paperplaneData['inspiration'],
//       category: paperplaneData['category'],
//       user: paperplaneData['user'],
//       background: paperplaneData['illustration']['background'],
//       base: paperplaneData['illustration']['base'],
//       detail: paperplaneData['illustration']['detail'],
//       pattern: paperplaneData['illustration']['pattern'],
//       stamp: paperplaneData['illustration']['stamp'],
//       wings: paperplaneData['illustration']['wings'],
//       likes: paperplaneData['likes'],
//       saved: false,
//     );
//   }

//   void setFromFirestore(DocumentSnapshot paperplaneDoc) {
//     Map paperplaneData = paperplaneDoc.data()! as Map;
//     id = paperplaneDoc.id;
//     date = DateTime.now();
//     quote = paperplaneData['quote'];
//     source = paperplaneData['source'];
//     inspiration = paperplaneData['inspiration'];
//     category = paperplaneData['category'];
//     user = paperplaneData['user'];
//     background = paperplaneData['illustration']['background'];
//     base = paperplaneData['illustration']['base'];
//     detail = paperplaneData['illustration']['detail'];
//     pattern = paperplaneData['illustration']['pattern'];
//     stamp = paperplaneData['illustration']['stamp'];
//     wings = paperplaneData['illustration']['wings'];
//     likes = paperplaneData['likes'];
//     saved = false;
//     notifyListeners();
//   }
// }
