import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/helper/functions.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_states.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/delivery_info_card.dart';
import 'package:flower_app/features/track_order/presentation/widgets/track_order_widgets/map_marker_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  GoogleMapController? _mapController;
  LatLng? _lastAnimatedDriverPosition;

  BitmapDescriptor? _driverMarkerIcon;
  BitmapDescriptor? _storeMarkerIcon;
  BitmapDescriptor? _destMarkerIcon;
  bool _ovalMarkersRequested = false;

  static const LatLng _fallbackCenter = LatLng(
    30.02599441795995,
    31.1991091073733,
  );

  @override
  void initState() {
    super.initState();
    _loadDriverMarkerIcon();
  }

  Future<void> _loadDriverMarkerIcon() async {
    try {
      final icon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/image/marker_app.png',
      );
      if (mounted) setState(() => _driverMarkerIcon = icon);
    } catch (_) {}
  }

  void _loadOvalMarkersIfNeeded(BuildContext context) {
    if (_ovalMarkersRequested || !context.mounted) return;
    _ovalMarkersRequested = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!context.mounted) return;

      final store = await createOvalMarkerIcon(
        context: context,
        icon: Icons.local_florist,
        label: 'Flowery',
      );

      if (!context.mounted) return;

      final dest = await createOvalMarkerIcon(
        context: context,
        icon: Icons.home_rounded,
        label: 'Apartment',
      );

      if (!mounted) return;

      setState(() {
        _storeMarkerIcon = store;
        _destMarkerIcon = dest;
      });
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _fitBoundsFromOrder(context);
  }

  void _fitBoundsFromOrder(BuildContext context) {
    final order = context.read<TrackOrderViewModel>().state.orderState.data;
    if (order == null) return;

    final points = <LatLng>[
      if (order.hasStorePosition)
        LatLng(order.storeLatDouble!, order.storeLngDouble!),
      if (order.hasDriverPosition) LatLng(order.latDouble!, order.longDouble!),
      if (order.hasDestPosition)
        LatLng(order.destLatDouble!, order.destLngDouble!),
    ];

    if (points.isEmpty) return;

    if (points.length == 1) {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: points.single, zoom: 14),
        ),
      );
      return;
    }

    double minLat = points.first.latitude, maxLat = points.first.latitude;
    double minLng = points.first.longitude, maxLng = points.first.longitude;
    for (final p in points) {
      minLat = min(minLat, p.latitude);
      maxLat = max(maxLat, p.latitude);
      minLng = min(minLng, p.longitude);
      maxLng = max(maxLng, p.longitude);
    }

    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        80,
      ),
    );
  }

  LatLng _computeInitialCenter(ActiveOrderEntity order) {
    if (order.hasDriverPosition) {
      return LatLng(order.latDouble!, order.longDouble!);
    }
    if (order.hasStorePosition) {
      return LatLng(order.storeLatDouble!, order.storeLngDouble!);
    }
    if (order.hasDestPosition) {
      return LatLng(order.destLatDouble!, order.destLngDouble!);
    }
    return _fallbackCenter;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackOrderViewModel, TrackOrderStates>(
      listenWhen: (prev, curr) =>
          prev.orderState.data?.lat != curr.orderState.data?.lat ||
          prev.orderState.data?.long != curr.orderState.data?.long,
      listener: (context, state) {
        final order = state.orderState.data;
        if (order == null ||
            !order.hasDriverPosition ||
            _mapController == null) {
          return;
        }
        final driverPos = LatLng(order.latDouble!, order.longDouble!);
        if (_lastAnimatedDriverPosition == driverPos) return;
        _lastAnimatedDriverPosition = driverPos;
        _mapController!.animateCamera(CameraUpdate.newLatLng(driverPos));
      },
      buildWhen: (prev, curr) => prev.orderState != curr.orderState,
      builder: (context, state) {
        final order = state.orderState.data;
        if (order == null) {
          return Center(
            child: CircularProgressIndicator(color: context.appTheme.primary),
          );
        }
        _loadOvalMarkersIfNeeded(context);
        return _MapContent(
          order: order,
          driverMarkerIcon: _driverMarkerIcon,
          storeMarkerIcon: _storeMarkerIcon,
          destMarkerIcon: _destMarkerIcon,
          initialCenter: _computeInitialCenter(order),
          onMapCreated: _onMapCreated,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Map Content
// ─────────────────────────────────────────────────────────────
class _MapContent extends StatelessWidget {
  final ActiveOrderEntity order;
  final BitmapDescriptor? driverMarkerIcon;
  final BitmapDescriptor? storeMarkerIcon;
  final BitmapDescriptor? destMarkerIcon;
  final LatLng initialCenter;
  final void Function(GoogleMapController) onMapCreated;

  const _MapContent({
    required this.order,
    required this.driverMarkerIcon,
    this.storeMarkerIcon,
    this.destMarkerIcon,
    required this.initialCenter,
    required this.onMapCreated,
  });

  Set<Marker> _buildMarkers() {
    final storeIcon =
        storeMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    final driverIcon =
        driverMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
    final destIcon =
        destMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);

    return {
      if (order.hasStorePosition)
        Marker(
          markerId: const MarkerId('store'),
          position: LatLng(order.storeLatDouble!, order.storeLngDouble!),
          icon: storeIcon,
          infoWindow: InfoWindow(
            title: order.storeName.isNotEmpty ? order.storeName : 'Flowery',
          ),
        ),
      if (order.hasDriverPosition)
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(order.latDouble!, order.longDouble!),
          icon: driverIcon,
        ),
      if (order.hasDestPosition)
        Marker(
          markerId: const MarkerId('destination'),
          position: LatLng(order.destLatDouble!, order.destLngDouble!),
          icon: destIcon,
          infoWindow: const InfoWindow(title: 'Apartment'),
        ),
    };
  }

  Set<Polyline> _buildPolylines(BuildContext context) {
    final points = <LatLng>[
      if (order.hasStorePosition)
        LatLng(order.storeLatDouble!, order.storeLngDouble!),
      if (order.hasDriverPosition) LatLng(order.latDouble!, order.longDouble!),
      if (order.hasDestPosition)
        LatLng(order.destLatDouble!, order.destLngDouble!),
    ];
    if (points.length < 2) return {};
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: points,
        color: context.appTheme.primary,
        width: 6,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          mapToolbarEnabled: false,
          initialCameraPosition: CameraPosition(
            target: initialCenter,
            zoom: 14.0,
          ),
          onMapCreated: onMapCreated,
          markers: _buildMarkers(),
          polylines: _buildPolylines(context),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _BottomCard(order: order),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Bottom Card — بياخد الداتا ويعرضها، والـ Intent بيبعته للـ VM
// ─────────────────────────────────────────────────────────────
class _BottomCard extends StatelessWidget {
  final ActiveOrderEntity order;

  const _BottomCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TrackOrderViewModel>();
    final arrivalDisplay = formatArrivalDate(order.startedAt);
    final deliveryName = resolveDeliveryName(order) ?? 'Driver';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => vm.doIntent(ShowOrderDetailsIntent()),
            child: Text('order_details'.tr()),
          ),
        ],
      ),
    );
  }
}
