class WacanaModel {
  final int id, total;
  final String title, jenis, content;

  WacanaModel({
    this.id,
    this.title,
    this.jenis,
    this.total,
    this.content,
  });

  WacanaModel.fromJson(parsedJson)
  : id = parsedJson['id'],
    title = parsedJson['title'],
    jenis = parsedJson['jenis'],
    total = parsedJson['total'],
    content = parsedJson['content'];
}