import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../graphql/model/book_model.dart';
import '../providers/book_provider.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: bookProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: bookProvider.books.length,
        itemBuilder: (context, index) {
          final book = bookProvider.books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text('${book.author} - ${book.year}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => showBookDialog(context, book: book),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => bookProvider.deleteBook(book.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBookDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void showBookDialog(BuildContext context, {Book? book}) {
    final authorController =
    TextEditingController(text: book?.author ?? '');
    final titleController =
    TextEditingController(text: book?.title ?? '');
    final yearController = TextEditingController(
        text: book?.year != null ? book!.year.toString() : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(book == null ? 'Add Book' : 'Edit Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Year'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final author = authorController.text;
                final title = titleController.text;
                final year = int.tryParse(yearController.text) ?? 0;

                final bookProvider =
                Provider.of<BookProvider>(context, listen: false);

                if (book == null) {
                  bookProvider.createBook(author, title, year);
                } else {

                  debugPrint('${book.id} >>>> ');
                  bookProvider.updateBook(book.id, author, title, year);
                }

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
