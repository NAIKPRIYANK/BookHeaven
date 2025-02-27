class Author {
  final int id;
  final String name;
  final String image;
  final String work;

  Author({
    required this.id,
    required this.name,
    required this.image,
    required this.work
  });

  /// Factory constructor to create an Author instance from JSON
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      work: json['work'] as String,
    );
  }

  /// Convert Author object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'work': work
    };
  }
}
