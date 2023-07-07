import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class BookService extends ChangeNotifier {
  List<Book> bookList = []; // 책 목록

  void search(String q) async { // await 를 쓰려면 함수명 뒤에 async를 써야함
    if (q.isNotEmpty) {
      Response res = await Dio().get( // 동기로 (get은 원래 비동기)
        "https://www.googleapis.com/books/v1/volumes?q=$q&startIndex=0&maxResults=40",
      );      
      
      List items = res.data["items"];
      for (Map<String, dynamic> item in items) {
        Book book = Book(
          id: item['id'],
          title: item['volumeInfo']['title'] ?? "",
          subtitle: item['volumeInfo']['subtitle'] ?? "",
          thumbnail: item['volumeInfo']['imageLinks']?['thumbnail'] ??
              "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg",
          previewLink: item['volumeInfo']['previewLink'] ?? "",
        );
        bookList.add(book);
      }
    }
  }
}
