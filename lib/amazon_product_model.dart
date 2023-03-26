

class AmazonProduct {

  const AmazonProduct({
    required this.url,
    required this.title,
    required this.images,
    required this.brand,
    required this.stars,
    required this.ratingsCount,
    required this.price,
    required this.currency,
    required this.specifications,
    required this.aboutThisItem,
    required this.productDetails,
    required this.reviews,
    required this.questions,
    required this.description,
    required this.importantInfo,
    required this.badges,
});

  final String url;
  final String title;
  final List<String> images;
  final String brand;
  final double stars;
  final int ratingsCount;
  final double price;
  final String currency;
  final Map<String, dynamic> specifications;
  final String aboutThisItem;
  final Map<String, dynamic> productDetails;
  final List<ReviewModel> reviews;
  final List<QuestionModel> questions;
  final String description;
  final String importantInfo;
  final Map<String, dynamic> badges;


}

class QuestionModel {

  QuestionModel({
    required this.question,
    required this.answer,
    required this.timeStamp,
  });

  final String question;
  final String answer;
  final DateTime timeStamp;


}

class ReviewModel {

  ReviewModel({
    required this.name,
    required this.image,
    required this.title,
    required this.review,
    required this.timeStamp,
    required this.stars,
  });

  final String name;
  final String image;
  final String title;
  final String review;
  final DateTime timeStamp;
  final double stars;


}
