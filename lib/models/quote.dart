
import 'dart:convert';

class Quote {
  final String id;
  final List<dynamic> tags;
  final String content;
  final String author;
  final int length;
  bool isFavorite;

  Quote({
    this.id,
    this.tags,
    this.content,
    this.author,
    this.length,
    this.isFavorite = false
  });

  factory Quote.fromJson(dynamic json) {
    return Quote(
      id: json['_id'] as String,
      tags: json['tags'] as List<dynamic>,
      content: json['content'] as String,
      author: json['author'] as String,
      length: json['length'] as int,
      isFavorite: false,
    );
  }

  @override
  String toString() {
    return '{${this.id}, ${this.tags}, ${this.content}, ${this.author}, ${this.length}, ${this.isFavorite}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': jsonEncode({
        'id': id,
        'tags': tags,
        'content': content,
        'author': author,
        'length': length,
        'isFavorite': isFavorite,
      })
    };
  }
}