import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/constants/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:lottie/lottie.dart';

class WaitingForPickupView extends StatelessWidget {
  final String orderId;

  const WaitingForPickupView({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track Order")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AppPaths.lottieSearch, width: 200, height: 200),
            Text(
              "looking_for_a_delivery_partner".tr(),
              textAlign: TextAlign.center,
              style: context.appTheme.medium20,
            ),
            const SizedBox(height: 12),

            Text(
              "your_order_is_confirmed_and_we're_currently".tr(),
              textAlign: TextAlign.center,
              style: context.appTheme.medium16.copyWith(
                color: context.appTheme.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.orange),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "waiting_for_courier_to_accept_the_order".tr(),
                      style: context.appTheme.regular14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
