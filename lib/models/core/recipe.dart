class Recipe {
  String title;
  String photo;
  String calories;
  String time;
  String description;

  List<Ingredient> ingredients;
  List<TutorialStep> tutorial;
  List<Review> reviews;

  Recipe({
    required this.title,
    required this.photo,
    required this.calories,
    required this.time,
    required this.description,
    required this.ingredients,
    required this.tutorial,
    required this.reviews,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? '',
      photo: json['photo'] ?? '',
      calories: json['calories'] ?? '',
      time: json['time'] ?? '',
      description: json['description'] ?? '',
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e))
          .toList() ??
          [],
      tutorial: (json['tutorial'] as List<dynamic>?)
          ?.map((e) => TutorialStep.fromJson(e))
          .toList() ??
          [],
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class TutorialStep {
  String step;
  String description;

  TutorialStep({
    required this.step,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'step': step,
      'description': description,
    };
  }

  factory TutorialStep.fromJson(Map<String, dynamic> json) {
    return TutorialStep(
      step: json['step'] ?? '',
      description: json['description'] ?? '',
    );
  }

  static List<TutorialStep> toList(List<Map<String, dynamic>> json) {
    return List.from(json).map((e) => TutorialStep.fromJson(e)).toList();
  }
}

class Review {
  String username;
  String review;

  Review({
    required this.username,
    required this.review,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      review: json['review'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'review': review,
    };
  }

  static List<Review> toList(List<Map<String, dynamic>> json) {
    return List.from(json).map((e) => Review.fromJson(e)).toList();
  }
}

class Ingredient {
  String name;
  String size;

  Ingredient({
    required this.name,
    required this.size,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      size: json['size'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'size': size,
    };
  }

  static List<Ingredient> toList(List<Map<String, dynamic>> json) {
    return List.from(json).map((e) => Ingredient.fromJson(e)).toList();
  }
}
