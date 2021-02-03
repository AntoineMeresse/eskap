class Review {
  int reviewId;
  String userId;
  String text;
  double rate;
  String date;

  bool isOwner;

  Review(
      {this.reviewId,
      this.userId,
      this.text,
      this.rate,
      this.date,
      this.isOwner});

  @override
  String toString() {
    return 'Review : $reviewId | $userId | $text | $rate | $date | ${isOwner.toString()}';
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
}
