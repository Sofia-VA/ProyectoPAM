// // ignore_for_file: unnecessary_this

// class Experience {
//   late final String authorID; //
//   late final List comments;
//   late final String locationID;
//   late final int date;
//   late final int likes;
//   late final String title; // Place Name
//   late final String country; // Country
//   late final String city; // City
//   late final String description; // General Information
//   late final List images; // Images
//   late final String longitude; // Longitud
//   late final String latitude; // Latitud
//   late final String weather; // Latitud
//   late final String rating; // Rating
//   late final String price; // Price
//   late final List<String> tags;

//   @override
//   String toString() {
//     return "(${this.title}:${this.country}:${this.city}:${this.description}:${this.longitude}:${this.latitude}:${this.weather}:${this.rating}:${this.price})";
//   }

//   Map<String, dynamic> getExperienceAsMap() {
//     return {
//       'authorID': this.authorID,
//       'comments': this.comments,
//       'locationID': this.locationID,
//       'date': this.date,
//       'likes': this.likes,
//       'title': this.title,
//       'country': this.country,
//       'city': this.city,
//       'description': this.description,
//       'images': this.images,
//       'longitud': this.longitude,
//       'latitude': this.latitude,
//       'weather': this.weather,
//       'rating': this.rating,
//       'price': this.price,
//       'tags': this.tags
//     };
//   }

//   Experience({
//     required this.authorID,
//     required this.comments,
//     required this.locationID,
//     required this.date,
//     required this.likes,
//     required this.title,
//     required this.country,
//     required this.city,
//     required this.description,
//     required this.images,
//     required this.longitude,
//     required this.latitude,
//     required this.weather,
//     required this.rating,
//     required this.price,
//     required this.tags,
//   });
// }

// ignore_for_file: unnecessary_this

class Experience {
  late final String title; // Place Name
  late final String country; // Country
  late final String city; // City
  late final String description; // General Information
  late final String image; // Images
  late final String longitude; // Longitud
  late final String latitude; // Latitud
  late final String weather; // Latitud
  late final String rating; // Rating
  late final String price; // Price
  late final List<String> tags;

  @override
  String toString() {
    return "(${this.title}:${this.country}:${this.city}:${this.description}:${this.longitude}:${this.latitude}:${this.weather}:${this.rating}:${this.price})";
  }

  Map<String, dynamic> getExperienceAsMap() {
    return {
      'title': this.title,
      'country': this.country,
      'city': this.city,
      'description': this.description,
      'image': this.image,
      'longitud': this.longitude,
      'latitude': this.latitude,
      'weather': this.weather,
      'rating': this.rating,
      'price': this.price,
      'tags': this.tags
    };
  }

  Experience({
    required this.title,
    required this.country,
    required this.city,
    required this.description,
    required this.image,
    required this.longitude,
    required this.latitude,
    required this.weather,
    required this.rating,
    required this.price,
    required this.tags,
  });
}
