import 'package:flower_app/features/checkout/presentation/models/payment_method_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentMethodModel', () {
    test('cash enum has correct method value', () {
      expect(PaymentMethodModel.cash.method, 'Cash');
    });

    test('card enum has correct method value', () {
      expect(PaymentMethodModel.card.method, 'Credit');
    });

    test('cash displayMethod returns correct string', () {
      expect(
        PaymentMethodModel.cash.displayMethod,
        'Cash on delivery',
      );
    });

    test('card displayMethod returns correct string', () {
      expect(
        PaymentMethodModel.card.displayMethod,
        'Credit card',
      );
    });

    test('enum contains exactly two values', () {
      expect(PaymentMethodModel.values.length, 2);
      expect(
        PaymentMethodModel.values,
        containsAll([
          PaymentMethodModel.cash,
          PaymentMethodModel.card,
        ]),
      );
    });
  });
}
