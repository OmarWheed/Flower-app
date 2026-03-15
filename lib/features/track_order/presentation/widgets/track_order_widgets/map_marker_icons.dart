import 'dart:ui' as ui;
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Builds oval marker icon (pink bg, white border, icon + label) as [BitmapDescriptor].
Future<BitmapDescriptor> createOvalMarkerIcon({
  required BuildContext context,
  required IconData icon,
  required String label,
}) async {
  final key = GlobalKey();
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (ctx) => Positioned(
      left: -200,
      top: -200,
      child: RepaintBoundary(
        key: key,
        child: _OvalMarkerWidget(icon: icon, label: label),
      ),
    ),
  );
  overlay.insert(entry);

  await Future<void>.delayed(const Duration(milliseconds: 100));

  BitmapDescriptor? descriptor;
  try {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary != null) {
      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData?.buffer.asUint8List();
      if (bytes != null) {
        descriptor = BitmapDescriptor.bytes(bytes);
      }
    }
  } catch (_) {
    // ignore
  } finally {
    entry.remove();
  }
  return descriptor ??
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
}

class _OvalMarkerWidget extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OvalMarkerWidget({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.appTheme.primary,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: context.appTheme.regular12.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
