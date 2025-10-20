import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<Map<String, DateTime>?> showDatePickerModal(BuildContext context) async {
  DateTime? selectedCheckIn;
  DateTime? selectedCheckOut;

  return showModalBottomSheet<Map<String, DateTime>?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Select Check-in Date",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Calendar
                CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                  onDateChanged: (date) {
                    setState(() {
                      if (selectedCheckIn == null ||
                          (selectedCheckIn != null && selectedCheckOut != null)) {
                        selectedCheckIn = date;
                        selectedCheckOut = null;
                      } else if (date.isAfter(selectedCheckIn!)) {
                        selectedCheckOut = date;
                      } else {
                        selectedCheckIn = date;
                        selectedCheckOut = null;
                      }
                    });
                  },
                ),

                const SizedBox(height: 10),

                // Selected dates display
                if (selectedCheckIn != null)
                  Center(
                    child: Text(
                      selectedCheckOut == null
                          ? "Check-in: ${DateFormat('dd MMM yyyy').format(selectedCheckIn!)}"
                          : "From ${DateFormat('dd MMM').format(selectedCheckIn!)} - To ${DateFormat('dd MMM yyyy').format(selectedCheckOut!)}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: selectedCheckIn != null && selectedCheckOut != null
                          ? () {
                              Navigator.pop(context, {
                                'checkIn': selectedCheckIn!,
                                'checkOut': selectedCheckOut!,
                              });
                            }
                          : null,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Set date",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
