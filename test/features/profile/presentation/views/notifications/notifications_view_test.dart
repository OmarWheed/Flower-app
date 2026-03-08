import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/profile/domain/entity/notification_entity.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/managers/notifications_view_contract.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/managers/notifications_view_keys.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/notifications_view.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/view_model/notifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_view_test.mocks.dart';

@GenerateMocks([NotificationsViewModel])
void main() {
  late MockNotificationsViewModel viewModel;

  Widget buildTestableWidget(NotificationsViewState state) {
    when(viewModel.state).thenReturn(state);
    when(viewModel.stream).thenAnswer((_) => Stream.value(state));

    return MaterialApp(
      theme: LightTheme().themeData,
      home: BlocProvider<NotificationsViewModel>.value(
        value: viewModel,
        child: const NotificationsView(),
      ),
    );
  }

  setUpAll(
    () =>
        provideDummy<NotificationsViewState>(NotificationsViewState.initial()),
  );

  setUp(() => viewModel = MockNotificationsViewModel());

  tearDown(() => reset(viewModel));

  group('NotificationsView Widget Tests', () {
    testWidgets('renders Scaffold and AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(NotificationsViewState.initial()),
      );

      expect(find.byKey(NotificationsViewKeys.scaffold), findsOneWidget);
      expect(find.byKey(NotificationsViewKeys.appBar), findsOneWidget);

      expect(find.byKey(NotificationsViewKeys.errorMsg), findsNothing);
      expect(find.byKey(NotificationsViewKeys.listViewBuilder), findsNothing);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('shows loading indicator on initial state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(NotificationsViewState.initial()),
      );

      expect(
        find.byKey(NotificationsViewKeys.loadingIndicator),
        findsOneWidget,
      );
      expect(find.byKey(NotificationsViewKeys.center), findsOneWidget);

      expect(find.byKey(NotificationsViewKeys.errorMsg), findsNothing);
      expect(find.byKey(NotificationsViewKeys.listViewBuilder), findsNothing);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('shows loading indicator on loading state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(NotificationsViewState(BaseState.loading())),
      );

      expect(find.byKey(NotificationsViewKeys.sizedBox), findsOneWidget);
      expect(find.byKey(NotificationsViewKeys.center), findsOneWidget);
      expect(
        find.byKey(NotificationsViewKeys.loadingIndicator),
        findsOneWidget,
      );

      expect(find.byKey(NotificationsViewKeys.errorMsg), findsNothing);
      expect(find.byKey(NotificationsViewKeys.listViewBuilder), findsNothing);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('shows error message when state is error', (
      WidgetTester tester,
    ) async {
      const errorMessage = 'Network error';

      await tester.pumpWidget(
        buildTestableWidget(
          NotificationsViewState(BaseState.error(errorMessage)),
        ),
      );

      expect(find.byKey(NotificationsViewKeys.errorMsg), findsOneWidget);
      expect(find.byKey(NotificationsViewKeys.center), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);

      expect(find.byKey(NotificationsViewKeys.loadingIndicator), findsNothing);
      expect(find.byKey(NotificationsViewKeys.listViewBuilder), findsNothing);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('shows empty ListView when loaded with empty list', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          NotificationsViewState(BaseState.loaded(<NotificationEntity>[])),
        ),
      );

      expect(find.byKey(NotificationsViewKeys.listViewBuilder), findsOneWidget);
      expect(find.byType(Card), findsNothing);

      expect(find.byKey(NotificationsViewKeys.loadingIndicator), findsNothing);
      expect(find.byKey(NotificationsViewKeys.errorMsg), findsNothing);
    });

    testWidgets('renders notifications list when loaded', (
      WidgetTester tester,
    ) async {
      final notifications = [
        const NotificationEntity(title: 'Title 1', body: 'Body 1'),
        const NotificationEntity(title: 'Title 2', body: 'Body 2'),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          NotificationsViewState(BaseState.loaded(notifications)),
        ),
      );

      expect(find.byKey(NotificationsViewKeys.listViewBuilder), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(2));
      expect(find.byType(ListTile), findsNWidgets(2));

      expect(find.byKey(NotificationsViewKeys.loadingIndicator), findsNothing);
      expect(find.byKey(NotificationsViewKeys.errorMsg), findsNothing);
    });

    testWidgets('renders notification item content correctly', (
      WidgetTester tester,
    ) async {
      const notification = NotificationEntity(
        title: 'New Message',
        body: 'You have a new message',
      );

      await tester.pumpWidget(
        buildTestableWidget(
          NotificationsViewState(BaseState.loaded([notification])),
        ),
      );

      expect(find.text('New Message'), findsOneWidget);
      expect(find.text('You have a new message'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_none_rounded), findsOneWidget);

      expect(find.byKey(NotificationsViewKeys.loadingIndicator), findsNothing);
      expect(find.byKey(NotificationsViewKeys.errorMsg), findsNothing);
    });
  });
}
