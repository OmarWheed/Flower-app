import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_state.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SliverAppBar(
      titleSpacing: -14,
      backgroundColor: theme.backgroundColor,
      scrolledUnderElevation: 0,
      pinned: true,
      title: BlocBuilder<OrderViewModel, OrderState>(
        builder: (context, state) {
          final items = state.orders?.data?.length ?? 0;
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "cart.cart".tr(), style: theme.medium20),
                TextSpan(
                  text: "\t($items ${"cart.items".tr()})",
                  style: theme.medium20.copyWith(color: theme.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
