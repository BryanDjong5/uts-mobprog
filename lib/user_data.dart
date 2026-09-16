class UserAccount {
  final String email;
  final String password;

  UserAccount({required this.email, required this.password});
}

class AppData {
  static List<UserAccount> registeredUsers = [
    UserAccount(email: "diana@gmail.com", password: "password123"),
  ];
}