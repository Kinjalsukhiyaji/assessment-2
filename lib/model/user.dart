class User{
  int? id;
  String? fname;
  String? lname;
  String? email;
  String? pass;

  User({ this.fname, this.lname, this.email, this.pass});

  Map<String, dynamic> toMap() {
    return {
      "fname": this.fname,
      "lname": this.lname,
      "email": this.email,
      "password": this.pass,
    };
  }

  User.withId({this.id, this.fname, this.lname, this.email, this.pass});

  factory User.fromJson(Map<String, dynamic> json) {
    return User.withId(
      id: int.parse(json["id"]),
      fname: json["fname"],
      lname: json["lname"],
      email: json["email"],
      pass: json["pass"],
    );
  }
}