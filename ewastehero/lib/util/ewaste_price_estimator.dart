import 'dart:convert';
import 'package:ewastehero/main.dart';
import 'package:http/http.dart' as http;

class EWastePriceEstimator {
  static const String apiUrl = 'https://api.openai.com/v1/chat/completions';
  static String apiKey = Config.openKey;

  static Future<double> estimatePrice(String itemDescription) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "gpt-4",
          "messages": [
            {"role": "system", "content": "You are an AI that estimates the average recycling value of e-waste items. Respond with only the estimated price in USD, no extra text."},
            {"role": "user", "content": "Estimate the recycling price of $itemDescription."}
          ],
          "max_tokens": 10,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String estimatedPrice = responseData["choices"][0]["message"]["content"].replaceAll(RegExp(r'[^\d.]'), '');

        return double.tryParse(estimatedPrice) ?? 0.0;
      } else {
        throw Exception('Failed to fetch price estimate');
      }
    } catch (e) {
      print('Error: $e');
      return 0.0;
    }
  }
}