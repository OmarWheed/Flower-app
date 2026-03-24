import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseStoreService {
  Future<void> set({
    required String collectionPath,
    required String userId,
    required Map<String, dynamic> data,
  });
}

@LazySingleton(as: FirebaseStoreService)
class DatabaseServiceImpl extends FirebaseStoreService {
  final FirebaseFirestore dbFirestore = FirebaseFirestore.instance;

  @override
  Future<void> set({
    required String collectionPath,
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    final doc = await dbFirestore.collection(collectionPath).doc(userId).get();

    if (doc.exists) {
      await dbFirestore.collection(collectionPath).doc(userId).update(data);
    } else {
      await dbFirestore.collection(collectionPath).doc(userId).set(data);
    }

  }
}
