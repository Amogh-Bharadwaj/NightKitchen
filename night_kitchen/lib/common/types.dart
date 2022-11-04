enum RecipeTags { spicy, sweet, savoury, salty, sour, bitter, tangy, bland }

extension ParseToString on RecipeTags {
  String toShortString() {
    return toString().split('.').last.toUpperCase().trim();
  }
}
