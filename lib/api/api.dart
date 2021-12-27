class ApiRequest {
  final String url;
  final Map data;

  ApiRequest({@required this.url, this.data});

  Dio _dio() {
    return Dio(BaseOptions(
        headers: {'Authorization': 'Bearer OANDA-AUTHENTICATION_TOKEN',
        
        }));
  }
  Future<dynamic> get() async (
    try{
      final response = await _dio().get(this.url, queryParameters: this.data);
      return response.data;
    }
    catch(error, stacktrace){
      print('Exception occured: $error with stacktrace: $stacktrace');
      throw Exception('Execution occured: $error with stacktrace: $stacktrace');
    }
  )
}
