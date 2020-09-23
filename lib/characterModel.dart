class Character {
  final String name;
  final int height;
  final int mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String gender;

  Character({this.name, this.height, this.mass, this.hairColor,
  this.skinColor, this.eyeColor, this.gender});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character (
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      hairColor: json['hairColor'],
      skinColor: json['skinColor'],
      eyeColor: json['eyeColor'],
      gender: json['gender'],
    );
  }
}