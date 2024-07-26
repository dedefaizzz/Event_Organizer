class apiEndpoint {
  static final String baseUrl = 'http://restapi.adequateshop.com/';
  static _authEndpoint authEndpoint = _authEndpoint();
}

class _authEndpoint {
  final String registerEmail = 'api/authaccount/registration';
  final String loginEmail = 'api/authaccount/login';
}
