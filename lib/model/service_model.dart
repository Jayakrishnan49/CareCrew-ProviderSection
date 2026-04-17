class WorkModel {
  final String id;
  final String workType;
  final String name;
  final double price;
  final String image;
  final bool completed;

  WorkModel({
    required this.id,
    required this.workType,
    required this.name,
    required this.price,
    required this.image,
    required this.completed,
  });

  WorkModel copyWith({
    String? id,
    String? workType,
    String? name,
    double? price,
    String? image,
    bool? completed,
  }) {
    return WorkModel(
      id: id ?? this.id,
      workType: workType ?? this.workType,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      completed: completed ?? this.completed,
    );
  }

  factory WorkModel.fromMap(String id, Map<String, dynamic> data) {
    return WorkModel(
      id: id,
      workType: data['workType'] ?? '',
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      image: data['image'] ?? '',
      completed: data['completed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workType': workType,
      'name': name,
      'price': price,
      'image': image,
      'completed': completed,
    };
  }
}