abstract interface class ApiHelper<T> {
  Future<T> get(String url, {Map<String, String>? headers});
  Future<T> post(String url, {Map<String, String>? headers, dynamic body});
  Future<T> put(String url, {Map<String, String>? headers, dynamic body});
  Future<T> delete(String url, {Map<String, String>? headers});
}
