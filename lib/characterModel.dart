class Character {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String gender;

  Character({this.name, this.height, this.mass, this.hairColor,
    this.skinColor, this.eyeColor, this.gender});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character (
      name: json['name'] as String,
      height: json['height'] as String,
      mass: json['mass'] as String,
      hairColor: json['hairColor'] as String,
      skinColor: json['skinColor'] as String,
      eyeColor: json['eyeColor'] as String,
      gender: json['gender'] as String,
    );
  }
}

