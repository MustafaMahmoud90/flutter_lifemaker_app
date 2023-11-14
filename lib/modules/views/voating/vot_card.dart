import 'package:flutter/material.dart';

class CardWidgets extends StatelessWidget {
  final String image;
  final String text;
  final IconData icon;
  final bool isVoted; // Add this property
  final VoidCallback? onTap;

  const CardWidgets({
    super.key,
    required this.image,
    required this.text,
    required this.icon,
    required this.isVoted, // Initialize isVoted
    this.onTap,
  });

  bool shouldShowIcon() {
    final now = DateTime.now();
    final targetStartTime = DateTime(now.year, now.month, now.day, 10, 0);
    final targetEndTime = DateTime(now.year, now.month, now.day, 22, 0);

    // يُظهر الأيقونة إذا كان الوقت الحالي يتوافق مع النطاق الزمني المحدد
    return now.isAfter(targetStartTime) && now.isBefore(targetEndTime);
  }

  @override
  Widget build(BuildContext context) {
    final bool showIcon = shouldShowIcon();

    return Card(
      elevation: 20, // Adjust the elevation as needed
      color: const Color(0xff0E395E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: isVoted
              ? Border.all(width: 5, color: const Color(0xffE9791E))
              : null, // Add condition here
        ),
        child: Column(
          // alignment: Alignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            CircleAvatar(
              radius: 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage.assetNetwork(
                  image: image,
                  placeholder:
                      'assets/user.jpg', // Replace with your placeholder image asset
                  width: 70, // Adjust the width as needed
                  height: 70, // Adjust the height as needed
                  fit: BoxFit.cover, // Adjust the BoxFit as needed
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 20,
                    child: Text(
                      text,
                      textAlign: TextAlign.right,
                      maxLines: isVoted ? 2 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Alamiri',
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (showIcon) // الأيقونة ستظهر إذا كانت الشرط صحيحة
                    GestureDetector(
                      onTap: onTap,
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
