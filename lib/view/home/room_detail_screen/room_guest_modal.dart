import 'package:flutter/material.dart';

Future<Map<String, int>?> showRoomGuestModal(
  BuildContext context, {
  required String roomType, // 🧩 new parameter
  int initialAdults = 1,
  int initialChildren = 0,
}) async {
  int adults = initialAdults;
  int children = initialChildren;

  // 🧠 Set limits based on room type
  int maxAdults = 2;
  int maxChildren = 0;
  int maxTotal = 2;
  bool allowExtras = false;

  switch (roomType.toLowerCase()) {
    case 'single':
      maxAdults = 1;
      maxChildren = 0;
      allowExtras = false;
      break;
    case 'double':
      maxAdults = 2;
      maxChildren = 2; // allow small number of children as extras
      allowExtras = true;
      maxTotal = 4;
      break;
    case 'couple':
      maxAdults = 2;
      maxChildren = 0;
      allowExtras = false;
      break;
    case 'family':
      maxAdults = 10;
      maxChildren = 6;
      allowExtras = true;
      maxTotal = 16;
      break;
  }

  return showModalBottomSheet<Map<String, int>?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          int totalGuests = adults + children;

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Select Guests for $roomType Room",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Adults Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Adults",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text("Ages 5 or Above",
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    Row(
                      children: [
                        _counterButton(
                          icon: Icons.remove,
                          onTap: adults > 1
                              ? () => setState(() => adults--)
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text("$adults",
                              style: const TextStyle(fontSize: 16)),
                        ),
                        _counterButton(
                          icon: Icons.add,
                          onTap: totalGuests < maxTotal && adults < maxAdults
                              ? () => setState(() => adults++)
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 30),

                // Children Row (only show if children are allowed)
                if (maxChildren > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Children",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text("Ages 0–5",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          _counterButton(
                            icon: Icons.remove,
                            onTap: children > 0
                                ? () => setState(() => children--)
                                : null,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text("$children",
                                style: const TextStyle(fontSize: 16)),
                          ),
                          _counterButton(
                            icon: Icons.add,
                            onTap: totalGuests < maxTotal &&
                                    children < maxChildren
                                ? () => setState(() => children++)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.pop(context, {
                          'adults': adults,
                          'children': children,
                        });
                      },
                      child: const Text(
                        "Set Room",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
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

Widget _counterButton({required IconData icon, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: onTap == null ? Colors.grey.shade300 : Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(6),
      child: Icon(icon, color: Colors.white, size: 18),
    ),
  );
}
