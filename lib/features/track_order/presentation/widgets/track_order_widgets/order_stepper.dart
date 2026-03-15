import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/track_order/domain/entity/order_status.dart';
import 'package:flutter/material.dart';

class OrderStepper extends StatelessWidget {
  final List<OrderStepEntity> steps;
  final OrderStatus currentStatus;

  const OrderStepper({
    super.key,
    required this.steps,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    // stepIndex: accepted=0, picked=1, outForDelivery=2, arrived=3, delivered=4
    // index < activeIndex  → done   → pink filled circle
    // index == activeIndex → active → radio-button (white + pink border + pink center)
    // index > activeIndex  → future → hollow grey circle
    final activeIndex = currentStatus.stepIndex;

    return Column(
      children: List.generate(steps.length, (index) {
        final isDone = index < activeIndex;
        final isActive = index == activeIndex;
        final isLast = index == steps.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                child: Column(
                  children: [
                    _buildDot(
                      isDone: isDone,
                      isActive: isActive,
                      context: context,
                    ),
                    if (!isLast) ...[
                      Expanded(
                        child: Center(
                          child: Container(
                            width: 1,
                            color: isDone
                                ? context.appTheme.primary
                                : context.appTheme.grey,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 38, top: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[index].title,
                        style: context.appTheme.regular14,
                      ),
                      if (steps[index].date.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          steps[index].date,
                          style: context.appTheme.regular14.copyWith(
                            color: context.appTheme.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDot({
    required bool isDone,
    required bool isActive,
    required BuildContext context,
  }) {
    if (isActive) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: context.appTheme.primary, width: 2),
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.appTheme.primary,
            ),
          ),
        ),
      );
    }

    if (isDone) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.appTheme.primary,
        ),
      );
    }
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: context.appTheme.grey),
      ),
    );
  }
}
