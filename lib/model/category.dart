class Category {
  int? id;
  String? CategoryName;

  Category({required this.CategoryName});

  Map<String, dynamic> toMap() {
    return {
      'CategoryName': this.CategoryName,
    };
  }

  Category.withId({this.id, this.CategoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category.withId(
      id: json['id'] as int? ?? 0, // Check for null and provide a default value (0 in this case)
      CategoryName: json['CategoryName'] as String? ?? '', // Check for null and provide a default empty string
    );
  }
}
