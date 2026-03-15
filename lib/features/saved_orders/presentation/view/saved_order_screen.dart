import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:flower_app/features/saved_orders/presentation/view/widgets/custom_order_card.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_cubit.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_events.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedOrdersScreen extends StatefulWidget {
  const SavedOrdersScreen({super.key});

  @override
  State<SavedOrdersScreen> createState() => _SavedOrdersScreenState();
}

class _SavedOrdersScreenState extends State<SavedOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SavedOrderCubit>().doIntent(GetSavedOrdersEvents());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("My orders").tr(),
      ),
      body: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            isScrollable: false,
            tabAlignment: TabAlignment.fill,
            tabs: [
              Tab(text: "Active".tr()),
              Tab(text: "Completed".tr()),
            ],
          ),
          Expanded(
            child: BlocBuilder<SavedOrderCubit, SavedOrderState>(
              builder: (context, state) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOrderList(state.activeOrders, isActive: true),
                    _buildOrderList(state.completedOrders, isActive: false),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(
    BaseState<List<SavedOrderEntity>>? ordersState, {
    required bool isActive,
  }) {
    if (ordersState == null ||
        ordersState.requestState == RequestState.loading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFD81B60)),
      );
    }

    if (ordersState.requestState == RequestState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              ordersState.errorMessage ?? "Failed to load orders".tr(),
              style: context.appTheme.regular12.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<SavedOrderCubit>().doIntent(
                  GetSavedOrdersEvents(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD81B60),
              ),
              child: const Text("Retry").tr(),
            ),
          ],
        ),
      );
    }

    final orders = ordersState.data ?? [];

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? Icons.inbox_outlined : Icons.check_circle_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              isActive ? "No active orders".tr() : "No completed orders".tr(),
              style: context.appTheme.regular16.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final List<OrderItemData> orderItemsList = [];
    for (var order in orders) {
      if (order.orderItems != null && order.orderItems!.isNotEmpty) {
        for (var item in order.orderItems!) {
          orderItemsList.add(OrderItemData(order: order, orderItem: item));
        }
      }
    }

    if (orderItemsList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? Icons.inbox_outlined : Icons.check_circle_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              isActive ? "No active orders".tr() : "No completed orders".tr(),
              style: context.appTheme.regular16.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orderItemsList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return CustomOrderCard(
          orderItemData: orderItemsList[index],
          isActive: isActive,
          onReorder: () {
            if (isActive) {
              Navigator.pushNamed(
                context,
                AppRoutes.trackOrder,
                arguments: orderItemsList[index].order.id,
              );
              //  Track Order
              //  Navigation to Track Order
            } else {
              //  Reorder
              // Navigation to Reorder
            }
          },
        );
      },
    );
  }
}
