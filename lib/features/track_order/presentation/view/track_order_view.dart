import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/features/track_order/presentation/view/order_tracking_view.dart';
import 'package:flower_app/features/track_order/presentation/view/waiting_for_pickup_view.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';

class TrackOrderView extends StatefulWidget {
  final String orderId;

  const TrackOrderView({super.key, required this.orderId});

  @override
  State<TrackOrderView> createState() => _TrackOrderViewState();
}

class _TrackOrderViewState extends State<TrackOrderView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TrackOrderViewModel>().doIntent(
        ListenToOrderIntent(widget.orderId),
      );
    });
  }

  void _retry() {
    context.read<TrackOrderViewModel>().doIntent(
      ListenToOrderIntent(widget.orderId),
    );
  }

  /// Rebuild when request state or loaded data changes (e.g. status, documentExists, lat/long from stream).
  bool _shouldRebuild(TrackOrderStates prev, TrackOrderStates curr) {
    if (prev.orderState.requestState != curr.orderState.requestState) {
      return true;
    }
    final prevData = prev.orderState.data;
    final currData = curr.orderState.data;
    if (prevData == currData) return false;
    if (prevData == null || currData == null) return true;
    return prevData.status != currData.status ||
        prevData.documentExists != currData.documentExists ||
        prevData.lat != currData.lat ||
        prevData.long != currData.long;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackOrderViewModel, TrackOrderStates>(
      buildWhen: (prev, curr) => _shouldRebuild(prev, curr),
      builder: (context, state) {
        final orderState = state.orderState;

        if (orderState.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: context.appTheme.primary),
          );
        }

        if (orderState.isError) {
          return _ErrorScreen(
            message: orderState.errorMessage ?? 'Something went wrong',
            onRetry: _retry,
          );
        }
        final order = orderState.data;
        if (order == null) {
          return Center(
            child: CircularProgressIndicator(color: context.appTheme.primary),
          );
        }
        if (!order.documentExists) {
          return WaitingForPickupView(orderId: widget.orderId);
        }
        return OrderTrackingScreen(order: order);
      },
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorScreen({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: context.appTheme.error,
              ),
              const SizedBox(height: 16),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}
