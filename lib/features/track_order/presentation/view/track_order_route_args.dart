/// Arguments for opening the track order screen.
/// [orderId] is required. [destLat] and [destLng] are optional and come from
/// the order's shipping address (e.g. when opening from saved orders) so the map
/// can show the "Apartment" marker even if Firestore document has no destLat/destLng.
class TrackOrderRouteArgs {
  final String orderId;
  final double? destLat;
  final double? destLng;

  const TrackOrderRouteArgs({
    required this.orderId,
    this.destLat,
    this.destLng,
  });

  /// Legacy: when route receives only [orderId] as String.
  static TrackOrderRouteArgs fromDynamic(dynamic arguments) {
    if (arguments is TrackOrderRouteArgs) return arguments;
    if (arguments is String) return TrackOrderRouteArgs(orderId: arguments);
    return TrackOrderRouteArgs(orderId: '');
  }
}
