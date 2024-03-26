
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Future<void> pushToDb(Map<String, dynamic> yourDocument, String documentId) async {
//   User? user = FirebaseAuth.instance.currentUser;
//   yourDocument['timestamp'] = FieldValue.serverTimestamp(); // Adding timestamp to your document
//   try {
//     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
//         .collection('${user?.email}') //
//         .doc(documentId)
//         .get();
//
//     if (documentSnapshot.exists) {
//       FirebaseFirestore.instance.collection('${user?.email}').add(yourDocument).then((DocumentReference doc) {
//         print('Document added with ID: ${doc.id}');
//       }).catchError((error) {
//         print('Error adding document: $error');
//       });
//     } else {
//       FirebaseFirestore.instance.collection("${user?.email}").doc(documentId).update(yourDocument).then((_) {
//         print('Document updated with ID: $documentId');
//       }).catchError((error) {
//         print('Error updating document: $error');
//       });
//     }
//   } catch (error) {
//     // Tangani kesalahan jika terjadi
//     print('Terjadi kesalahan: $error');
//   }
//
//
// }

Future<void> pushToDb(Map<String, dynamic> yourDocument, String documentId) async {
  User? user = FirebaseAuth.instance.currentUser;
  yourDocument['timestamp'] = FieldValue.serverTimestamp(); // Adding timestamp to your document
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('${user?.email}') //
        .doc(documentId)
        .get();

    if (documentSnapshot.exists) {
      FirebaseFirestore.instance.collection("${user?.email}").doc(documentId).update(yourDocument).then((_) {
        print('Document updated with ID: $documentId');
      }).catchError((error) {
        print('Error updating document: $error');
      });

    } else {
      FirebaseFirestore.instance.collection('${user?.email}').doc(documentId).set(yourDocument).then((_) {
        print('Document added with ID: $documentId');
      }).catchError((error) {
        print('Error adding document: $error');
      });
    }
  } catch (error) {
    // Tangani kesalahan jika terjadi
    print('Terjadi kesalahan: $error');
  }


}