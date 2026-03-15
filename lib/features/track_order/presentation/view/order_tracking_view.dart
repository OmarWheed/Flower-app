import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/helper/assets_manager.dart';
import 'package:flower_app/core/helper/functions.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/domain/entity/order_status.dart';
import 'package:flower_app/features/track_order/presentation/view/map_view.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/delivery_info_card.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/order_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackingScreen extends StatefulWidget {
  final ActiveOrderEntity order;
  const OrderTrackingScreen({super.key, required this.order});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  StreamSubscription<TrackOrderUIEvents>? _uiEventsSubscription;
  late final TrackOrderViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<TrackOrderViewModel>();
    _listenToUIEvents();
  }

  void _listenToUIEvents() {
    _uiEventsSubscription = _viewModel.uiEventsStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case NavigatePopScreen():
          Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _uiEventsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackOrderViewModel, TrackOrderStates>(
      builder: (context, state) {
        final order = state.orderState.data ?? widget.order;

        return Scaffold(
          appBar: AppBar(title: Text('track_order'.tr())),
          body: state.showMap
              ? const SafeArea(child: MapsView())
              : _DetailView(order: order),
        );
      },
    );
  }
}

class _DetailView extends StatelessWidget {
  final ActiveOrderEntity order;

  const _DetailView({required this.order});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TrackOrderViewModel>();
    final isDelivered = order.orderStatus == OrderStatus.delivered;
    final arrivalDisplay = formatArrivalDate(order.startedAt);
    final deliveryName = resolveDeliveryName(order);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (arrivalDisplay != null) ...[
                      Text(
                        'estimated_arrival'.tr(),
                        style: context.appTheme.regular14.copyWith(
                          color: context.appTheme.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(arrivalDisplay, style: context.appTheme.medium16),
                      const SizedBox(height: 16),
                    ],
                    DeliveryInfoCard(
                      deliveryName: deliveryName,
                      deliveryPhone: order.phone,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: CustomImageView(imagePath: AssetsManager.icCarSvg),
                    ),
                    const SizedBox(height: 40),
                    OrderStepper(
                      steps: defaultOrderSteps(),
                      currentStatus: order.orderStatus,
                    ),
                  ],
                ),
              ),
            ),
            if (isDelivered)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => vm.doIntent(ShowMapIntent()),
                      child: Text('show_map'.tr()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => vm.doIntent(OrderDeliveredIntent()),
                      child: Text('order_delivered'.tr()),
                    ),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: () => vm.doIntent(ShowMapIntent()),
                child: Text('show_map'.tr()),
              ),
          ],
        ),
      ),
    );
  }
}
