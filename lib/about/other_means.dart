// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherMeans extends StatelessWidget {
  const OtherMeans({
    super.key,
  });

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
          child: const Text(
            'وسائل التبرع',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        expandedTitleScale: 1,
        titlePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        collapseMode: CollapseMode.parallax,
        background: Hero(
            tag: '',
            child: Image.network(
              'https://lifemakers.org/wp-content/uploads/2023/01/header2.jpg',
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
            height: 2.5, // Set the line height to 2
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
      // backgroundColor: Color(0xff0E395E),
      // appBar: AppBar(),
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
                    ShowWidget(
                      text:
                          'عن طريق تطبيق ميجا خير أو رسالة هاتفية عبر رقم ٩٦٩٥ ',
                      pic:
                          'https://lifemakers.org/wp-content/uploads/2020/05/miga-150x150.png',
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                     Divider(
                      thickness: 1.5,
                      color: Colors.black.withOpacity(0.4),
                     
                    ),
                    ShowWidget(
                      text:
                          'كود (950) \n خدمة فوري بالمحافظ الإلكترونية المختلفة',
                      pic:
                          'https://lifemakers.org/wp-content/uploads/2020/05/fawry-150x150.png',
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                     Divider(
                      thickness: 1.5,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    ShowWidget(
                      text:
                          'خطوات التبرع\n 1- ادخل على Donations\n 2- اختار تطبيق ميجا خير\n 3- من الجمعيات اختار التبرع لمؤسسة صناع الحياة مصر',
                      pic:
                          'https://lifemakers.org/wp-content/uploads/2017/03/anavod.png',
                    ),
                     const SizedBox(
                      height: 0.5,
                    ),
                     Divider(
                      thickness: 1.5,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    ShowWidget(
                      text: 'عن طريق منافذ أمان ',
                      pic:
                          'https://lifemakers.org/wp-content/uploads/2023/04/aman-250x240-1.jpg',
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                     Divider(
                      thickness: 1.5,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    ShowWidget(
                      text: 'عن طريق تطبيق جوميا باي',
                      pic:
                          'https://lifemakers.org/wp-content/uploads/2017/03/jp.png',
                    ),
                     const SizedBox(
                      height: 0.5,
                    ),
                     Divider(
                      thickness: 1.5,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    ShowWidget(
                      text: 'من خلال منافذ مصاري',
                      pic:
                          'https://lifemakers.org/wp-content/uploads/2020/05/%D9%85%D8%B5%D8%A7%D8%B1%D9%8A-150x150.png',
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                     Divider(
                      thickness: 1.5,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    ShowWidget(
                      text: 'شركة ضامن',
                      pic:
                          'https://lifemakers.org/wp-content/uploads/2020/05/damn-1-150x150.jpg',
                    ),
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

class ShowWidget extends StatelessWidget {
  String text;
  String pic;
  ShowWidget({super.key, required this.text, required this.pic});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(pic),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
