import 'package:flutter/material.dart';
import 'package:graphqldemo/env/app_env.dart';

import '../graphql/model/book_model.dart';
import '../graphql/mutation/book_mutations.dart';
import '../graphql/query/book_queries.dart';
import '../graphql/service/books_service.dart';

class BookProvider with ChangeNotifier {
  final GraphQLService _graphqlService = GraphQLService();
  List<Book> books = [];
  bool isLoading = false;

  BookProvider() {
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    setLoading(true);
    try {
      final result = await _graphqlService.runQuery(
        BookQueries.getBooks,
        variables: {"limit": 10},
      );

      if (!result.hasException && result.data != null) {
        books = (result.data?['getBooks'] as List)
            .map((bookJson) => Book.fromJson(bookJson))
            .toList();
      } else {
        debugPrint("Error fetching books: ${result.exception.toString()}");
      }
    } catch (error) {
      debugPrint("Error: $error");
    }
    setLoading(false);
  }

  Future<void> createBook(String author, String title, int year) async {
    setLoading(true);
    try {
      final result = await _graphqlService.runMutation(
        BookMutations.createBook,
        variables: {
          "bookInput": {
            "author": author,
            "title": title,
            "year": year,
          }
        },
      );

      if (!result.hasException) {
        fetchBooks(); // Refresh the book list after creating
      } else {
        debugPrint("Create Error: ${result.exception.toString()}");
      }
    } catch (error) {
      debugPrint("Error: $error");
    }
    setLoading(false);
  }

  Future<void> updateBook(String id, String author, String title, int year) async {
    setLoading(true);
    try {
      final result = await _graphqlService.runMutation(
        BookMutations.updateBook,
        variables: {
          "id": id,
          "bookInput": {
            "author": author,
            "title": title,
            "year": year,
          }
        },
      );

      if (!result.hasException) {
        fetchBooks(); // Refresh the book list after updating
      } else {
        debugPrint("Update Error: ${result.exception.toString()}");
      }
    } catch (error) {
      debugPrint("Error: $error");
    }
    setLoading(false);
  }

  Future<void> deleteBook(String id) async {
    setLoading(true);
    try {
      final result = await _graphqlService.runMutation(
        BookMutations.deleteBook,
        variables: {"id": id},
      );

      if (!result.hasException) {
        fetchBooks(); // Refresh the book list after deleting
      } else {
        debugPrint("Delete Error: ${result.exception.toString()}");
      }
    } catch (error) {
      debugPrint("Error: $error");
    }
    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
