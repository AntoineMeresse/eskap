import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final int reviewId;
  final String userId;
  final String text;
  final double rate;
  final String date;

  Review({this.reviewId, this.userId, this.text, this.rate, this.date});

  @override
  String toString() {
    return 'Review : $reviewId | $userId | $text | $rate | $date';
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
