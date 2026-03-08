import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/theme/theme_extension.dart';
import 'package:flower_app/features/saved_orders/data/models/response/saved_order_response.dart';
import 'package:flower_app/features/saved_orders/domain/entity/saved_order_entity.dart';
import 'package:flower_app/features/saved_orders/presentation/view/saved_order_screen.dart';
import 'package:flower_app/features/saved_orders/presentation/view/widgets/custom_order_card.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_cubit.dart';
import 'package:flower_app/features/saved_orders/presentation/view_model/saved_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_order_screen_test.mocks.dart';

@GenerateMocks([SavedOrderCubit])
void main() {
  late MockSavedOrderCubit cubit;
  late List<SavedOrderEntity> mockActiveOrders;
  late List<SavedOrderEntity> mockCompletedOrders;

  setUp(() {
    cubit = MockSavedOrderCubit();
    mockActiveOrders = [
      SavedOrderEntity(
        id: '1',
        state: 'active',
        orderItems: [OrderItems(id: 'item1', price: 10, quantity: 1)],
      ),
      SavedOrderEntity(
        id: '2',
        state: 'active',
        orderItems: [OrderItems(id: 'item2', price: 20, quantity: 1)],
      ),
    ];
    mockCompletedOrders = [
      SavedOrderEntity(
        id: '1',
        state: 'completed',
        orderItems: [OrderItems(id: 'item1', price: 10, quantity: 1)],
      ),
      SavedOrderEntity(
        id: '2',
        state: 'completed',
        orderItems: [OrderItems(id: 'item2', price: 20, quantity: 1)],
      ),
    ];

    when(cubit.stream).thenAnswer((_) => const Stream.empty());
    when(cubit.doIntent(any)).thenReturn(null);
  });
  Widget buildTestableWidget() {
    return MaterialApp(
      locale: const Locale('en'),
      theme: ThemeData(
        extensions: <ThemeExtension<dynamic>>[testAppThemeExtension()],
      ),
      home: BlocProvider<SavedOrderCubit>.value(
        value: cubit,
        child: const SavedOrdersScreen(),
      ),
    );
  }

  testWidgets('test loading state', (WidgetTester tester) async {
    //arrange
    when(cubit.state).thenReturn(
      const SavedOrderState(
        activeOrders: BaseState(requestState: RequestState.loading),
        completedOrders: BaseState(requestState: RequestState.loading),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsNWidgets(1));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("My orders"), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.byType(Tab), findsNWidgets(2));
    expect(find.text("Active"), findsOneWidget);
    expect(find.text("Completed"), findsOneWidget);
    expect(find.byType(TabBarView), findsOneWidget);
  });
  testWidgets('test loaded state IN active tab with empty orders', (
    WidgetTester tester,
  ) async {
    mockActiveOrders = [
      SavedOrderEntity(id: '1', state: 'active'),
      SavedOrderEntity(id: '2', state: 'active'),
    ];
    //arrange
    when(cubit.state).thenReturn(
      SavedOrderState(
        activeOrders: BaseState(
          requestState: RequestState.loaded,
          data: mockActiveOrders,
        ),
      ),
    );

    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();
    expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    expect(find.text("No active orders"), findsOneWidget);
  });
  testWidgets('test loaded state IN completed tab with empty orders', (
    WidgetTester tester,
  ) async {
    mockCompletedOrders = [
      SavedOrderEntity(id: '1', state: 'completed'),
      SavedOrderEntity(id: '2', state: 'completed'),
    ];
    //arrange
    when(cubit.state).thenReturn(
      SavedOrderState(
        completedOrders: BaseState(
          requestState: RequestState.loaded,
          data: mockCompletedOrders,
        ),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.text('Completed'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.text("No completed orders"), findsOneWidget);
  });

  testWidgets('test loaded state IN active tab with data', (
    WidgetTester tester,
  ) async {
    //arrange
    when(cubit.state).thenReturn(
      SavedOrderState(
        activeOrders: BaseState(
          requestState: RequestState.loaded,
          data: mockActiveOrders,
        ),
        completedOrders: BaseState(
          requestState: RequestState.loaded,
          data: mockCompletedOrders,
        ),
      ),
    );
    when(cubit.stream).thenAnswer(
      (_) => Stream.value(
        SavedOrderState(
          activeOrders: BaseState(
            requestState: RequestState.loaded,
            data: mockActiveOrders,
          ),
          completedOrders: BaseState(
            requestState: RequestState.loaded,
            data: mockCompletedOrders,
          ),
        ),
      ),
    );

    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();
    expect(find.byType(CustomOrderCard), findsNWidgets(2));
  });
  testWidgets('test loaded state IN completed tab with data', (
    WidgetTester tester,
  ) async {
    //arrange
    when(cubit.state).thenReturn(
      SavedOrderState(
        activeOrders: BaseState(
          requestState: RequestState.loaded,
          data: mockActiveOrders,
        ),
        completedOrders: BaseState(
          requestState: RequestState.loaded,
          data: mockCompletedOrders,
        ),
      ),
    );
    when(cubit.stream).thenAnswer(
      (_) => Stream.value(
        SavedOrderState(
          activeOrders: BaseState(
            requestState: RequestState.loaded,
            data: mockActiveOrders,
          ),
          completedOrders: BaseState(
            requestState: RequestState.loaded,
            data: mockCompletedOrders,
          ),
        ),
      ),
    );

    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CustomOrderCard), findsNWidgets(2));
  });
  testWidgets('test error state with error message', (
    WidgetTester tester,
  ) async {
    //arrange
    when(cubit.state).thenReturn(
      const SavedOrderState(
        activeOrders: BaseState(
          requestState: RequestState.error,
          errorMessage: "error",
        ),
        completedOrders: BaseState(
          requestState: RequestState.error,
          errorMessage: "error",
        ),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());
    expect(find.text("error"), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
  testWidgets('test error state without error message', (
    WidgetTester tester,
  ) async {
    //arrange
    when(cubit.state).thenReturn(
      const SavedOrderState(
        activeOrders: BaseState(
          requestState: RequestState.error,
          errorMessage: null,
        ),
        completedOrders: BaseState(
          requestState: RequestState.error,
          errorMessage: null,
        ),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());
    expect(find.text("Failed to load orders"), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
  testWidgets('test click Retry button when state is error ', (
    WidgetTester tester,
  ) async {
    //arrange
    when(cubit.state).thenReturn(
      const SavedOrderState(
        activeOrders: BaseState(
          requestState: RequestState.error,
          errorMessage: null,
        ),
        completedOrders: BaseState(
          requestState: RequestState.error,
          errorMessage: null,
        ),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text("Retry"), findsOneWidget);
  });
}

AppThemeExtension testAppThemeExtension() {
  const baseTextStyle = TextStyle(fontSize: 14);

  return AppThemeExtension(
    semiBold24: baseTextStyle,
    medium20: baseTextStyle,
    semiBold18: baseTextStyle,
    medium13: baseTextStyle,
    medium16: baseTextStyle,
    regular16: baseTextStyle,
    regular14: baseTextStyle,
    regular12: baseTextStyle,
    semiBold12: baseTextStyle,
    primary: Colors.pink,
    secondary: Colors.grey,
    surface: Colors.grey,
    backgroundColor: Colors.white,
    error: Colors.red,
    success: Colors.green,
    grey: Colors.grey,
    lightPink: Colors.pinkAccent,
    kDefaultRainbowColors: const [],
  );
}
