class UserAccount {
  final String? avatarUrl;
  final String? firstName;
  final String? lastName;

  UserAccount({this.avatarUrl, this.firstName, this.lastName});

  dynamic toMap() {
    return {
      'avatarUrl': avatarUrl,
      'firstName': firstName,
      'lastName': lastName
    };
  }
}
