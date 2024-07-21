class User {
  bool? isAgreed;
  User({this.isAgreed});

  User copyWith({
    bool? isAgreed,
  }) {
    return User(
      isAgreed: isAgreed ?? this.isAgreed,
    );
  }
}
