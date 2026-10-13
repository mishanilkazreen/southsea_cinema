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

  String get formattedPrice => '£${(ticketPrice / 100).toStringAsFixed(2)}';

  bool get isChildFriendly => ageRating == 'U' || ageRating == 'PG';

  bool get isAdultOnly => ageRating == '18';
}
