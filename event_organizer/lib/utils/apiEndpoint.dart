class apiEndpoint {
  static final String baseUrl = 'http://restapi.adequateshop.com/api/';
  static _authEndpoint authEndpoint = _authEndpoint();
}

class _authEndpoint {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = 'authaccount/login';
}
