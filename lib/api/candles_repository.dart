import 'package:flutter_application_4/api/api.dart';
import 'package:intl/intl.dart';

class CandlesRepository {
  Future<Candles>(String instrument, String granularity) async {
    final today = DateFormat('yyyy-MM-dd'.format(
      DateTime.now(),
    );
    final url = ''
    try{
      final response = await ApiRequest(url: url, data:null).get();
      return Candles.fromJson(response);
    }catch(error){
      throw(Exception('Exception occured with error $error'));
    }
  }
}
