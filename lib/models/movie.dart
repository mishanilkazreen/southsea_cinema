class Movie {
  final String id;
  final String name;
  final String ageRating;
  final int publishedYear;
  final String description;
  final String imagePath;
  final int ticketPrice;
  final List<String> screenings;

  const Movie({
    required this.id,
    required this.name,
    required this.ageRating,
    required this.publishedYear,
    required this.description,
    required this.imagePath,
    required this.ticketPrice,
    required this.screenings,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] as String;
    final String name = json['name'] as String;
    final String ageRating = json['ageRating'] as String;
    final int publishedYear = json['publishedYear'] as int;
    final String description = json['description'] as String;
    final String imagePath = json['imagePath'] as String;
    final num priceNumber = json['ticketPrice'] as num;
    final int ticketPrice = priceNumber.toInt();

    final List<dynamic> screeningsJson = json['screenings'] as List<dynamic>;
    final List<String> screenings = [];
    for (final dynamic screening in screeningsJson) {
      screenings.add(screening as String);
    }

    return Movie(
      id: id,
      name: name,
      ageRating: ageRating,
      publishedYear: publishedYear,
      description: description,
      imagePath: imagePath,
      ticketPrice: ticketPrice,
      screenings: screenings,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'name': name,
      'ageRating': ageRating,
      'publishedYear': publishedYear,
      'description': description,
      'imagePath': imagePath,
      'ticketPrice': ticketPrice,
      'screenings': screenings,
    };
    return data;
  }

  String get formattedPrice => '£${(ticketPrice / 100).toStringAsFixed(2)}';

  bool get isChildFriendly => ageRating == 'U' || ageRating == 'PG';

  bool get isAdultOnly => ageRating == '18';
}
