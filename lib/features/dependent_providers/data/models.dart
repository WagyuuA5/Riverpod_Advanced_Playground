class Product {
  final String id;
  final String name;
  final String category;

  const Product({required this.id, required this.name, required this.category});
}

class User {
  final String name;
  final int viewCount;

  const User({required this.name, required this.viewCount});
  
  User copyWith({String? name, int? viewCount}) {
    return User(
      name: name ?? this.name,
      viewCount: viewCount ?? this.viewCount,
    );
  }
}
