import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl; // 이미지를 담을 변수

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // 좋아요 여부
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // 가로의 부축(세로) 방향으로 위에 붙음
      // row col 위젯 안에 children들을 그려내면 됨
      children: [
        // 이미지 들어갈 자리
        ClipRRect(
          // CilpRRect 를 통해 이미지에 곡선 border 생성
          borderRadius: BorderRadius.circular(8),
          // 이미지
          child: Image.network(
            widget.imageUrl, // 10번째 줄의 imageUrl 가져오기
            width: 100,
            height: 100,
            fit: BoxFit.cover, // 이미지 비율 유지하면서 위젯에 맞춰줌
          ),
        ),
        SizedBox(width: 12), // 이미지랑 글 사이에 빈칸 넣음
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 'M1 아이패드 프로 11형(3세대) 와이파이 128G 팝니다.'
              // '봉천동 · 6분 전'
              // '100만원'
              Text(
                'M1 아이패드 프로 11형(3세대) 와이파이 128G 팝니다.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                '봉천동 · 6분 전',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '100만원',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  // 빈 칸
                  // 하트 아이콘
                  // '1'
                  Spacer(), // 나머지 요소 다 밀어내서 차지할 수 있는 모든 공간 차지함
                  GestureDetector(
                    // 위젯을 버튼으로 만듦
                    onTap: () {
                      // 화면 갱신
                      setState(() {
                        isFavorite = !isFavorite; // 좋아요 토글
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          isFavorite // 삼항연산자
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: isFavorite ? Colors.pink : Colors.black,
                          size: 16,
                        ),
                        Text(
                          '1',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
