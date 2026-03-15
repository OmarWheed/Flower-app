import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/core/app/presentation/view/app_section.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_contracts.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/features/address/presentation/view/add_new_address_view.dart';
import 'package:flower_app/features/address/presentation/view/google_map_view.dart';
import 'package:flower_app/features/address/presentation/view/save_address_view.dart';
import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flower_app/features/auth/presentation/cubit/change_password/change_password_view_model.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/pages/change_password/change_password_view.dart';
import 'package:flower_app/features/auth/presentation/pages/forget_password/forget_password_view.dart';
import 'package:flower_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flower_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:flower_app/features/categories/presentation/view/manager/categories_view_model.dart';
import 'package:flower_app/features/checkout/presentation/view/check_out_view.dart';
import 'package:flower_app/features/checkout/presentation/view/payment_view.dart';
import 'package:flower_app/features/home/presentation/view/best_seller_view.dart';
import 'package:flower_app/features/home/presentation/view/occasions/occasion_screen.dart';
import 'package:flower_app/features/home/presentation/view/search_view.dart';
import 'package:flower_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/features/orders/presentation/view_model/order_viewmodel.dart';
import 'package:flower_app/features/product_details/presentation/views/product_details_view.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_view_model.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/edit_profile_view.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/about_us_view.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/view_model/main_profile_view_model.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/managers/notifications_view_contract.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/notifications_view.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/view_model/notifications_view_model.dart';
import 'package:flower_app/features/saved_orders/presentation/view/saved_order_screen.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_cubit.dart';
import 'package:flower_app/features/terms/presentation/manager/terms_intent.dart';
import 'package:flower_app/features/terms/presentation/terms_view.dart';
import 'package:flower_app/features/terms/presentation/view_model/terms_view_model.dart';
import 'package:flower_app/features/track_order/presentation/view/track_order_view.dart';
import 'package:flower_app/features/track_order/presentation/view_model/track_order_view_model/track_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/saved_orders/presentation/view_model/saved_order_events.dart';
import '../di/di.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String appSection = "appSection";
  static const String forgetPassword = "/forgetPassword";
  static const String terms = '/terms';
  static const String mostSelling = '/mostSelling';
  static const String productDetails = '/productDetails';
  static const String occasion = '/occasion';
  static const String editProfile = '/editProfile';
  static const String resetPassword = '/resetPassword';
  static const String testScreen = '/TestScreen';
  static const String changePassword = '/changePassword';
  static const String orders = '/orders';
  static const String addNewAddress = '/addNewAddress';
  static const String notifications = '/notifications';
  static const String aboutUs = '/aboutUs';
  static const String search = '/search';
  static const String googleMapService = '/googleMapService';
  static const String saveAddress = '/saveAddress';
  static const String checkout = '/checkout';
  static const String payment = '/payment';
  static const String savedOrders = '/savedOrders';
  static const String trackOrder = '/trackOrder';
}

Route? onGenerateRoute(RouteSettings settings) {
  var addressViewModel = getIt.get<AddressViewModel>();

  switch (settings.name) {
    case AppRoutes.mostSelling:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<OrderViewModel>.value(
          value: getIt.get<OrderViewModel>(),
          child: const BestSellerView(),
        ),
      );

    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    case AppRoutes.appSection:
      var appSectionsViewModel = getIt.get<AppSectionViewModel>();
      var homeViewModel = getIt.get<HomeViewModel>();
      var categoriesViewModel = getIt.get<CategoriesViewModel>();
      var mainProfileViewModel = getIt.get<MainProfileViewModel>();

      return MaterialPageRoute(
        settings: settings,
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider<OrderViewModel>(
              create: (context) => getIt.get<OrderViewModel>(),
            ),
            BlocProvider<AppSectionViewModel>(
              create: (_) =>
                  appSectionsViewModel..doIntent(AppSectionInitIntent()),
            ),
            BlocProvider(
              create: (_) => homeViewModel..doIntent(FetchHomeData()),
            ),
            BlocProvider(create: (_) => categoriesViewModel),
            BlocProvider(create: (_) => mainProfileViewModel),
          ],
          child: Builder(
            builder: (context) {
              return KeyedSubtree(
                key: ValueKey(context.locale.toString()),
                child: const AppSection(),
              );
            },
          ),
        ),
      );

    case AppRoutes.login:
      var cubit = getIt.get<LoginViewModel>();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => cubit,
          child: const LoginScreen(),
        ),
      );

    case AppRoutes.terms:
      var viewModel = getIt.get<TermsViewModel>();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => viewModel..doIntent(FetchTermsIntent()),
          child: const TermsView(),
        ),
      );

    case AppRoutes.occasion:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<OrderViewModel>.value(
          value: getIt.get<OrderViewModel>(),
          child: const OccasionScreen(),
        ),
        settings: settings,
      );

    case AppRoutes.productDetails:
      final args = settings.arguments as ProductsEntity;
      return MaterialPageRoute(
        builder: (_) => BlocProvider<OrderViewModel>.value(
          value: getIt.get<OrderViewModel>(),
          child: ProductDetailsView(product: args),
        ),
      );

    case AppRoutes.forgetPassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt.get<ForgetPasswordCubit>(),
          child: const ForgetPasswordView(),
        ),
      );

    case AppRoutes.editProfile:
      final EditProfileViewModel editProfileViewModel =
          getIt<EditProfileViewModel>();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => editProfileViewModel,
          child: const EditProfileView(),
        ),
      );

    case AppRoutes.changePassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt.get<ChangePasswordViewModel>(),
          child: const ChangePasswordView(),
        ),
      );

    case AppRoutes.saveAddress:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider.value(
          value: addressViewModel,
          child: const SaveAddressView(),
        ),
      );

    case AppRoutes.addNewAddress:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider<AddressViewModel>.value(
          value: addressViewModel,
          child: const AddNewAddressView(),
        ),
      );

    case AppRoutes.googleMapService:
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: addressViewModel,
          child: const GoogleMapView(),
        ),
      );

    case AppRoutes.checkout:
      return MaterialPageRoute(
        builder: (_) => const CheckoutView(),
        settings: settings,
      );

    case AppRoutes.payment:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider<OrderViewModel>.value(
          value: getIt<OrderViewModel>(),
          child: const PaymentView(),
        ),
      );

    case AppRoutes.aboutUs:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt.get<AboutUsViewModel>(),
          child: const AboutUsView(),
        ),
      );

    case AppRoutes.search:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<OrderViewModel>.value(
          value: getIt<OrderViewModel>(),
          child: const SearchView(),
        ),
      );
    case AppRoutes.savedOrders:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) =>
              getIt.get<SavedOrderCubit>()..doIntent(GetSavedOrdersEvents()),
          child: const SavedOrdersScreen(),
        ),
      );
    case AppRoutes.notifications:
      var viewModel = getIt.get<NotificationsViewModel>();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => viewModel..doIntent(FetchNotificationsIntent()),
          child: const NotificationsView(),
        ),
      );

    case AppRoutes.trackOrder:
      final orderId = settings.arguments as String;
      var viewModel = getIt<TrackOrderViewModel>();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => viewModel,
          child: TrackOrderView(orderId: orderId),
        ),
      );
    default:
      return null;
  }
}
