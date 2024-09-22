class BookQueries {
  static const String getBook = r'''
    query GetBook($id: ID!) {
      getBook(ID: $id) {
        _id
        author
        title
        year
      }
    }
  ''';

  static const String getBooks = r'''
    query GetBooks($limit: Int) {
      getBooks(limit: $limit) {
        _id
        author
        title
        year
      }
    }
  ''';
}
