class User {
  int? id;
  String? firstN;
  String? lastN;
  String? phone;
  String? email;
  String? image;

  String? token;

  User(
      {this.id,
      this.firstN,
      this.lastN,
      this.phone,
      this.email,
      this.image,
      this.token});

  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        firstN: json['user']['firstN'],
        lastN: json['user']['lastN'],
        phone: json['user']['phone'],
        email: json['user']['email'],
        image: json['user']['image'],
        token: json['token']);
  }
}
