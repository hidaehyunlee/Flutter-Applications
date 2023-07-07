import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class BookService extends ChangeNotifier {
  List<Book> bookList = []; // 책 목록
  List<Book> likedBookList = []; // 좋아요 책 목록

  //- 좋아요가 눌러져 있지 않은 경우 (likedBookList 에 없는 경우) -> 좋아요 추가 (likedBookList 에 추가)
  //- 좋아요가 이미 눌러져있다면 (likedBookList 에 있는 경우) -> 좋아요 취소 (likedBookList 에서 제거)
  void toggleLikeBook({required Book book}) {
    String bookId = book.id;
    if (likedBookList.map((book) => book.id).contains(bookId)) {
      likedBookList.removeWhere((book) => book.id == bookId);
    } else {
      likedBookList.add(book);
    }
    notifyListeners();
  }

  void search(String q) async {
    // await 를 쓰려면 함수명 뒤에 async를 써야함
    bookList.clear(); // 검색 버튼 누를때 이전 데이터들을 지워주기

    if (q.isNotEmpty) {
      Response res = await Dio().get(
        // 동기로 (get은 원래 비동기)
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
    notifyListeners(); // 해당 Service 의 Consumer 로 등록된 모든 위젯의 builder 함수를 재호출해 화면을 새로고침
  }
}
