class User {
  final String firstname;
  final String lastname;
  final String number;
  final String bith;
  final String email;
  final String isActive;
  final String isDeleted;

  User({this.firstname, this.lastname, this.email, this.bith, this.number,this.isActive,this.isDeleted});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstname: json['firstname'],
      lastname: json['firstname'],
      number: json['number'],
      bith: json['bith'],
      email: json['email'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
    );
  }
}
