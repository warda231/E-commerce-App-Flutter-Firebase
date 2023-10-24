class User {
  String firstName;
  String lastName;
  String email;
  String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  // Factory constructor to create a User instance from a Map (often used when fetching data from Firestore or APIs).
  

  // Method to convert a User instance to a Map (often used when saving data to Firestore or APIs).
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toJson()=> {
    'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
    );
  }
}
