import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final int reviewId;
  final String userId;
  final String text;
  final double rate;
  final String date;

  final bool isOwner;

  Review(
      {this.reviewId,
      this.userId,
      this.text,
      this.rate,
      this.date,
      this.isOwner});

  @override
  String toString() {
    return 'Review : $reviewId | $userId | $text | $rate | $date | ${isOwner.toString}';
  }

  static Review fromJson(review, userId) {
    var isOwner = (userId == review['userId']) ? true : false;
    return Review(
        reviewId: review['reviewId'],
        userId: review['userId'],
        text: review['text'],
        rate: review['rate'],
        date: review['date'],
        isOwner: isOwner);
  }

  Map<String, dynamic> toJson() =>
      {"userId": userId, "text": text, "rate": rate, "date": date};

  static Review updateReviewFromPrevious(
      Review review, String userId, String date, bool isOwner) {
    return Review(
        reviewId: review.reviewId,
        userId: userId,
        text: review.text,
        rate: review.rate,
        date: date,
        isOwner: isOwner);
  }

  @override
  List<Object> get props => [reviewId, userId, text, rate, date, isOwner];
}
