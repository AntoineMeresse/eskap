class Review {
  int reviewId;
  String userId;
  String text;
  double rate;
  String date;

  Review({this.reviewId, this.userId, this.text, this.rate, this.date});

  @override
  String toString() {
    return 'Review : $reviewId | $userId | $text | $rate | $date';
  }

  static Review fromJson(review) {
    return Review(
        reviewId: review['reviewId'],
        userId: review['userId'],
        text: review['text'],
        rate: review['rate'],
        date: review['date']);
  }

  Map<String, dynamic> toJson() =>
      {"userId": userId, "text": text, "rate": rate, "date": date};
}
