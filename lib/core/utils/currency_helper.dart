class CurrencyHelper {

  static const Map<String, double> ratesToVND = {
    'VND': 1,
    'USD': 25300,
    'EUR': 27500,
    'JPY': 170,
  };

  static double convert({
    required double amount,
    required String originalCurrency,
    required String targetCurrency,
  }) {
    if (originalCurrency == targetCurrency) return amount;

    double amountInVND = amount * (ratesToVND[originalCurrency] ?? 1);

    double finalRate = ratesToVND[targetCurrency] ?? 1;

    return amountInVND / finalRate;
  }

  static String format(double amount, String currency) {
    return "${amount.toStringAsFixed(0)} $currency";
  }
}
