class User {
  final String name;      // Nama pengguna
  final String email;     // Email pengguna
  final String password;  // Password pengguna

  User({
    required this.name,
    required this.email,
    required this.password,
  });

  // Mengubah objek User menjadi JSON (untuk API request)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Membuat User dari JSON (untuk respons API)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'], // Bisa jadi hanya digunakan untuk login
    );
  }
}
