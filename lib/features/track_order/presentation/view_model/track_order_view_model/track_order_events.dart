sealed class Intent {}

class ListenToOrderIntent extends Intent {
  final String orderId;
  ListenToOrderIntent(this.orderId);
}

class DisposeOrderListenerIntent extends Intent {}

class ShowMapIntent extends Intent {}

class ShowOrderDetailsIntent extends Intent {}

class OrderDeliveredIntent extends Intent {}

/// Optional destination from order's shipping address (e.g. when opening from saved orders).
class SetDestinationOverrideIntent extends Intent {
  final double? destLat;
  final double? destLng;
  SetDestinationOverrideIntent({this.destLat, this.destLng});
}

// ─── UI Events (Stream) ───────────────────────────────
sealed class TrackOrderUIEvents {}

class NavigatePopScreen extends TrackOrderUIEvents {}
