import 'package:flutter_application_4/api/api.dart';
import 'package:flutter_application_4/model/price.dart';
import 'package:flutter_forex_app/model/price.dart';

class PriceRepository {
  final String accountNr = 'OANDA-ACCOUNT_ID';
  final String instruments =
      'EUR_USD,GBP_USD,USD_JPY,EUR_GBP,USD_CAD,USD_CHF,NZD_CHF,USD_HKD,USD_SGD';

  Future<List<Price>> getPricelist() async {
    final url =
        'https://api-fxpractice.oanda.com/v3/accounts/$accountNr/pricing?instruments=$instruments';
    final response = await ApiRequest(url: url).get();
    List<Price> prices =
        (response['prices'] as List)?.map((p) => Price.fromJson(p))?.toList() ??
            List.empty();
    return prices;
  }

  Future<Price> getPrice(String instrument) async {
    final url =
        'https://api-fxpractice.oanda.com/v3/accounts/$accountNr/pricing?instruments-$instrument';
    final response = await ApiRequest(url: url).get();
    return Price.fromJson(response['prices'][0]);
  }
}
