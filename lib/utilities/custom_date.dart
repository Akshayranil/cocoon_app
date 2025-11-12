import 'package:intl/intl.dart';

String formatDate(String dateString) {
  // Example input: "06/11/2025"
  final parts = dateString.split('/');
  final date = DateTime(
    int.parse(parts[2]), // year
    int.parse(parts[1]), // month
    int.parse(parts[0]), // day
  );

  // Output format: 6 Oct 2025
  return DateFormat('d MMM yyyy').format(date);
}
