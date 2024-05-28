
class Profile {
  final int id;
  final String preferences;
  final String name;
  final String city;
  final String horoscop;
  final String age;
  final List<String> labels;
  final String photoUrl;

  Profile({
    required this.id,
    required this.preferences,
    required this.name,
    required this.city,
    required this.horoscop,
    required this.age,
    required this.labels,
    required this.photoUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      preferences: json['preferences'],
      name: json['name'],
      city: json['city'],
      horoscop: json['horoscop'],
      age: json['age'],
      labels: List<String>.from(json['labels']),
      photoUrl: json['photoUrl'],
    );
  }
}
