class NewsModel {
  int? id;
  String? title;
  String? slug;
  String? image;
  String? description;
  int? authorId;
  String? createdAt;
  String? updatedAt;

  NewsModel(
      {this.id,
      this.title,
      this.slug,
      this.image,
      this.description,
      this.authorId,
      this.createdAt,
      this.updatedAt});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    description = json['description'];
    authorId = json['author_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['description'] = description;
    data['author_id'] = authorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
