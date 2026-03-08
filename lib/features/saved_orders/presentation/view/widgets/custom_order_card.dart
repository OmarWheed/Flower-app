import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:flutter/material.dart';

class OrderItemData {
  final SavedOrderEntity order;
  final OrderItems orderItem;

  OrderItemData({required this.order, required this.orderItem});
}

class CustomOrderCard extends StatelessWidget {
  final OrderItemData orderItemData;
  final VoidCallback? onReorder;
  final bool isActive;

  const CustomOrderCard({
    super.key,
    required this.orderItemData,
    this.onReorder,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final order = orderItemData.order;
    final item = orderItemData.orderItem;
    final product = item.product;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomImageView(
              imagePath: product?.imgCover,
              radius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                Text(
                  product?.title ?? "Product".tr(),
                  style: context.appTheme.regular12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "EGP ${item.price ?? 0}",
                  style: context.appTheme.medium16,
                ).tr(),

                Text(
                  isActive
                      ? tr(
                          'track_order_number',
                          args: [order.orderNumber ?? "N/A"],
                        )
                      : tr(
                          'delivered_on',
                          args: [
                            formatDateByAppLocale(context, order.updatedAt),
                          ],
                        ),
                  style: context.appTheme.regular12,
                ),

                const SizedBox(height: 4),

                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onReorder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD81B60),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isActive ? "Track Order".tr() : "Reorder".tr(),
                      style: context.appTheme.medium16.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDateByAppLocale(BuildContext context, String? dateString) {
    if (dateString == null) return "N/A";
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('d MMM yyyy', context.locale.languageCode).format(date);
    } catch (_) {
      return dateString;
    }
  }
}
