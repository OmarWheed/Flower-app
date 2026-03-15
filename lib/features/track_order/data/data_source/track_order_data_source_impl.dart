import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/track_order/data/data_source/track_order_data_source.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderDataSource)
class TrackOrderDataSourceImpl implements TrackOrderDataSource {
  final FirebaseFirestore firestore;

  TrackOrderDataSourceImpl(this.firestore);

  @override
  Stream<Result<ActiveOrderEntity>> listenToOrder({required String orderId}) {
    try {
      return firestore.collection('active_orders').doc(orderId).snapshots().map(
        (snapshot) {
          if (!snapshot.exists || snapshot.data() == null) {
            return Success<ActiveOrderEntity>(
              ActiveOrderEntity(orderId: orderId, documentExists: false),
            );
          }
          final entity = _fromFirestore(snapshot.data()!, orderId);
          return Success<ActiveOrderEntity>(entity);
        },
      );
    } catch (e) {
      return Stream.value(Failure<ActiveOrderEntity>(e.toString()));
    }
  }

  static ActiveOrderEntity _fromFirestore(
    Map<String, dynamic> data,
    String orderId,
  ) {
    final startedAtRaw = data['startedAt'];
    DateTime? startedAt;
    if (startedAtRaw is Timestamp) {
      startedAt = startedAtRaw.toDate();
    }

    return ActiveOrderEntity(
      orderId: orderId,
      documentExists: true,
      driverId: data['driverId'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      driverToken: data['driverToken'] as String? ?? '',
      userToken: data['userToken'] as String? ?? '',
      storeName: data['storeName'] as String? ?? '',
      storeAddress: data['storeAddress'] as String? ?? '',
      storeImage: data['storeImage'] as String? ?? '',
      storeLat: data['storeLat'] as String?,
      storeLng: data['storeLng'] as String?,
      driverName: data['driverName'] as String?,
      userName: data['userName'] as String? ?? '',
      userImage: data['userImage'] as String? ?? '',
      userAddress: data['userAddress'] as String? ?? '',
      destLat: data['destLat'] as String?,
      destLng: data['destLng'] as String?,
      totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0,
      status: data['status'] as String? ?? '',
      startedAt: startedAt,
      long: data['long'] as String?,
      lat: data['lat'] as String?,
      city: data['city'] as String?,
      street: data['street'] as String?,
      phone: data['phone'] as String?,
    );
  }
}
