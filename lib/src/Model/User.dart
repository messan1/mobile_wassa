class UserModel {
  final String uid;
  final String firstname;
  final String lastname;
  final String number;
  final String bith;
  final String email;
  final String active;
  final String isDeleted;

  UserModel(
      {
        this.uid,
      this.firstname,
      this.lastname,
      this.email,
      this.bith,
      this.number,
      this.active,
      this.isDeleted});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      firstname: json['firstname'],
      lastname: json['firstname'],
      number: json['number'],
      bith: json['bith'],
      email: json['email'],
      active: json['active'],
      isDeleted: json['isDeleted'],
    );
  }

  factory UserModel.fromMap(Map json) {
    return UserModel(
      uid: json['uid'] ?? "",
      firstname: json['firstname'] ?? "",
      lastname: json['firstname'] ?? "",
      number: json['number'] ?? "",
      bith: json['bith'] ?? "",
      email: json['email'] ?? "",
      active: json['active'] ?? "",
      isDeleted: json['isDeleted'] ?? "",
    );
  }
}
