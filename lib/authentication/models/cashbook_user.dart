class CashbookUser {
  final String email;
  final String password;

  CashbookUser(this.email, this.password);

  CashbookUser.fromMap(Map<String, dynamic> data)
      : email = data['email'],
        password = data['password'];

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}
