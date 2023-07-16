extension Truncate on String {
  String truncate({int max = 40}) {
    return (length <= max) ? this : '${substring(0, max)}...';
  }
}
