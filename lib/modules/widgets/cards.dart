import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final ImageProvider image;
  final ImageProvider image2;
  final String text;
  final VoidCallback? ontap;
  final bool isAvilable; // Add this property

  const CardWidget(
      {super.key,
      required this.image,
      required this.image2,
      required this.text,
      this.ontap,
      required this.isAvilable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvilable
          ? ontap
          : () {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text('قريبًا '),
              //     duration: Duration(seconds: 2),
              //   ),
              // );
              // AwesomeDialog(
              //   context: context,
              //   dialogType: DialogType
              //       .info, // You can choose the dialog type you prefer
              //   animType: AnimType.SCALE,
              //   title: 'قريبًا ',
              // ).show();
            },
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: isAvilable ? Color(0xffE9791E) : Colors.transparent,
              blurRadius: 8,
              spreadRadius: -3),
        ], borderRadius: BorderRadius.circular(20)),
        child: Card(
          shadowColor: Colors.amber,
          color: isAvilable ? const Color(0xffE9791E) : Color(0xffdcdddd),
          semanticContainer: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: isAvilable ? image : image2,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AboutWidget extends StatelessWidget {
  final ImageProvider image;
  final ImageProvider image2;
  final String text;
  final VoidCallback? ontap;
  final bool isAvilable; // Add this property

  const AboutWidget(
      {super.key,
      required this.image,
      required this.image2,
      required this.text,
      this.ontap,
      required this.isAvilable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvilable
          ? ontap
          : () {},     
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: isAvilable ? Color(0xffE9791E) : Colors.transparent,
              blurRadius: 8,
              spreadRadius: -3),
        ], borderRadius: BorderRadius.circular(20)),
        child: Card(
          shadowColor: Colors.amber,
          color: isAvilable ? const Color(0xffE9791E) : Color(0xffdcdddd),
          semanticContainer: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: isAvilable ? image : image2,
                width: 70,
                height: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class InfoWidget extends StatelessWidget {
  final ImageProvider image;
  final ImageProvider image2;
  final String text;
  final VoidCallback? ontap;
  final bool isAvilable; // Add this property

  const InfoWidget(
      {super.key,
      required this.image,
      required this.image2,
      required this.text,
      this.ontap,
      required this.isAvilable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvilable
          ? ontap
          : () {},     
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: isAvilable ? Color(0xffE9791E) : Colors.transparent,
              blurRadius: 8,
              spreadRadius: -3),
        ], borderRadius: BorderRadius.circular(20)),
        child: Card(
          shadowColor: Colors.amber,
          color: isAvilable ? const Color(0xffE9791E) : Color(0xffdcdddd),
          semanticContainer: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: isAvilable ? image : image2,
                width: 75,
                height: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class OtherMeansWidgets extends StatelessWidget {
  final ImageProvider image;
  final ImageProvider image2;
  final String text;
  final VoidCallback? ontap;
  final bool isAvilable; // Add this property

  const OtherMeansWidgets(
      {super.key,
      required this.image,
      required this.image2,
      required this.text,
      this.ontap,
      required this.isAvilable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvilable
          ? ontap
          : () {},     
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: isAvilable ? Color(0xffE9791E) : Colors.transparent,
              blurRadius: 8,
              spreadRadius: -3),
        ], borderRadius: BorderRadius.circular(20)),
        child: Card(
          shadowColor: Colors.amber,
          color: isAvilable ? const Color(0xffE9791E) : Color(0xffdcdddd),
          semanticContainer: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: isAvilable ? image : image2,
                width: 75,
                height: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
