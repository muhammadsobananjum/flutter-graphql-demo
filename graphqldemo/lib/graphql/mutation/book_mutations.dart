class BookMutations {
  static const String createBook = r'''
    mutation CreateBook($bookInput: BookInput!) {
      createBook(bookInput: $bookInput)
    }
  ''';

  static const String updateBook = r'''
    mutation UpdateBook($id: ID!, $bookInput: BookInput!) {
      updateBook(ID: $id, bookInput: $bookInput)
    }
  ''';

  static const String deleteBook = r'''
    mutation DeleteBook($id: ID!) {
      deleteBook(ID: $id)
    }
  ''';
}
