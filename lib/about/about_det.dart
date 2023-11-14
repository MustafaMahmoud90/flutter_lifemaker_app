import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutDetails extends StatelessWidget {
   final Map<String, String> imageData;

   const AboutDetails({super.key, required this.imageData});

  Widget buildSilverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500, excludeHeaderSemantics: true,
      automaticallyImplyLeading: true,
      // pinned: false,
      elevation: 7,
      centerTitle: false,
      floating: false,
      pinned: true,
      leading: IconButton(
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(171, 14, 57, 94))),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          CupertinoIcons.arrow_right,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white, opticalSize: 200),
      // collapsedHeight: 100,
      stretch: false,
      backgroundColor: const Color(0xff0E395E),
      // forceMaterialTransparency: false,
      scrolledUnderElevation: 3,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        stretchModes: const [StretchMode.blurBackground],
        title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffE9791E),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
               imageData["name"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        expandedTitleScale: 1,
        titlePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        collapseMode: CollapseMode.parallax,
        background: Hero(
            tag:'',
            child: Image.network(
              imageData["image"]!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
  Widget charInfo(String title, String value) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Alamiri',
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            fontFamily: 'Alamiri',
            height: 2.5,
            color: Colors.black,
            // fontWeight: FontWeight.bold,

            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          buildSilverAppBar(context),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // charInfo('الأسم : ', e.name!),
                    charInfo(  "قصص نجاح المتطوع/ ",  imageData["description"]!),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
