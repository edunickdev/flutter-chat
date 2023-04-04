import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getChats() async {
  List chats = [];
  CollectionReference collectionReference = db.collection('chats');

  QuerySnapshot queryChats = await collectionReference.get();

  queryChats.docs.forEach((element) {
    chats.add(element.data());
  });
  return chats;
}
