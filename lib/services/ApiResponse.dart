class ApiResponse {
  Object? _data;
  Object? _apiError;

  Object? get data => _data;
  set data(data) => _data = data;

  Object? get apiError => _apiError;
  set apiError(value) {
    _apiError = value;
  }

}