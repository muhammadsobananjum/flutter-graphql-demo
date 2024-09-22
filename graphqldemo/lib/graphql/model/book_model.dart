class Book {
  final String id;
  final String author;
  final String title;
  final int year;

  Book({
    required this.id,
    required this.author,
    required this.title,
    required this.year,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      author: json['author'],
      title: json['title'],
      year: json['year'],
    );
  }
}
