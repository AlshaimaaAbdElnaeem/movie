import 'package:flutter/material.dart';

class YouMayLikeCard extends StatelessWidget {
  final String title;
  final List<String> categories;
  final String imageUrl;
  final VoidCallback onTap; // إضافة دالة onTap 

  const YouMayLikeCard({
    required this.title,
    required this.categories,
    required this.imageUrl,
    required this.onTap, // استلام دالة onTap
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // استدعاء الدالة عند النقر على الكارد
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 14.0),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          Text(
            categories.join(', '),
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
