//this interface is teh contract for api
abstract class ApiConsumer{
  Future<dynamic> get(String path , {Map<String , dynamic>? queryParameters});
  Future<dynamic> post(String path , {Map<String , dynamic>? body,Map<String , dynamic>? queryParameters});
  Future<dynamic> put(String path , {Map<String , dynamic>? body,Map<String , dynamic>? queryParameters});
  Future<dynamic> delete(String path , {Map<String , dynamic>? body,Map<String , dynamic>? queryParameters});
  Future<dynamic> patch(String path , {Map<String , dynamic>? body,Map<String , dynamic>? queryParameters});
}