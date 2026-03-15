sealed class Intent {}

class ListenToOrderIntent extends Intent {
  final String orderId;
  ListenToOrderIntent(this.orderId);
}

class DisposeOrderListenerIntent extends Intent {}

class ShowMapIntent extends Intent {}

class ShowOrderDetailsIntent extends Intent {}

class OrderDeliveredIntent extends Intent {}

// ─── UI Events (Stream) ───────────────────────────────
sealed class TrackOrderUIEvents {}

class NavigatePopScreen extends TrackOrderUIEvents {}
