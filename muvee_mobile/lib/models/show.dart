class Show {
  int id;
  String? name;
  List<String>? genres;
  String? status;
  String? type;
  String? websiteURL;
  double? rating;
  String? imageURL;
  String? summary;

  Show({
    required this.id,
    this.name,
    this.type,
    this.genres,
    this.status,
    this.websiteURL,
    this.rating,
    this.imageURL,
    this.summary,
  });

  factory Show.fromMap(Map<String, dynamic> data) => Show(
        id: data['id'],
        name: data['name'] ?? '',
        genres:
            (data['genres'] as List<dynamic>).map((e) => e.toString()).toList(),
        status: data['status'] ?? '',
        type: data['type'] ?? '',
        websiteURL: data['officialSite'] ?? '',
        rating: double.tryParse(data['rating']['average'].toString()) ?? 0.0,
        imageURL: data['image'] == null ? null : data['image']['medium'],
        summary: data['summary'] ?? '',
      );
}
