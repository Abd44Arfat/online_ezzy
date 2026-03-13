class StripeConfig {
  StripeConfig._();

  /// TODO: Replace with your Stripe publishable key (pk_live_... or pk_test_...)
  static const String publishableKey = 'pk_test_REPLACE_ME';

  /// iOS only: merchant identifier (only needed for Apple Pay).
  static const String merchantIdentifier = 'merchant.com.onlineezzy';
}

