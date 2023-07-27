// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ReadingProcess {
  String bookId;
  List<double> chapters;
  ReadingProcess({
    required this.bookId,
    required this.chapters,
  });

  ReadingProcess copyWith({
    String? bookId,
    List<double>? chapters,
  }) {
    return ReadingProcess(
      bookId: bookId ?? this.bookId,
      chapters: chapters ?? this.chapters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookId': bookId,
      'chapters': chapters,
    };
  }

  factory ReadingProcess.fromMap(Map<String, dynamic> map) {
    return ReadingProcess(
      bookId: map['bookId'] ?? '',
      chapters: List<double>.from(map['chapters'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReadingProcess.fromJson(String source) => ReadingProcess.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ReadingProcess.fromJson2(String source) {
    final readingProcess = json.decode(source);
    return ReadingProcess(
      bookId: readingProcess['bookId'] ?? '',
      chapters: List<double>.from(readingProcess['chapters'] ?? []),
    );
  }

  @override
  String toString() => 'ReadingProcess(bookId: $bookId, chapters: $chapters)';

  @override
  bool operator ==(covariant ReadingProcess other) {
    if (identical(this, other)) return true;

    return other.bookId == bookId && listEquals(other.chapters, chapters);
  }

  @override
  int get hashCode => bookId.hashCode ^ chapters.hashCode;
}
