
class Quote {
  final String id;
  final List<dynamic> tags;
  final String content;
  final String author;
  final int length;

  Quote(
    this.id,
    this.tags,
    this.content,
    this.author,
    this.length
  );

  factory Quote.fromJson(dynamic json) {
    return Quote(json['_id'] as String, json['tags'] as List<dynamic>, json['content'] as String, json['author'] as String, json['length'] as int);
  }

  @override
  String toString() {
    return '{${this.id}, ${this.tags}, ${this.content}, ${this.author}, ${this.length}}';
  }
}