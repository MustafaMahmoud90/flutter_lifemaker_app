// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutInfo extends StatelessWidget {
  const AboutInfo({
    super.key,
  });

  Widget buildSilverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500, excludeHeaderSemantics: true,
      automaticallyImplyLeading: true,
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
            'صناع الحياة',
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
              'https://lifemakers.org/wp-content/uploads/2023/01/image-1.jpg',
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
                    const Text(
                      '  مؤسسة صناع الحياة مصر (LMF) هي مؤسسة أهلية وطنية غير حكومية وغير هادفة للربح أسست عام 2011 ومسجلة مركزيا برقم قيد 839 لسنة 2018 وتعمل طبقا لقانون الجمعيات والمؤسسات الأهلية المصري.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ShowWidget(
                      text:
                          ' المؤسسة قائمة على التطوع وتعمل منذ نشأتها على تنمية الشباب لبناء قدراتهم من أجل العمل على تنمية المجتمعات والاستجابة لاحتياجاتهم الإنسانية والإغاثية. ',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShowWidget(
                      text:
                          ' المؤسسة تعمل مباشرةً من خلال مكاتبها وفروعها المنتشرة في أنحاء الجمهورية وكذا من خلال الجمعيات والمنظمات الشريكة في مجالات تنمية الشباب، التعليم، الصحة، سبل كسب العيش والاحتياجات الأساسية والبيئة. ',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShowWidget(
                      text:
                          ' تتبني المؤسسة مبادئ العمل الإنساني الأساسية: الإنسانية والحيادية والعمل طبقا للاحتياج والاستقلالية، في جميع الأعمال التي تقوم بها وذلك للتأكد من أن تقديم المساعدات يتم دون التمييز طبقا للعرق، الدين، النوع أو أي اعتبارات أخري، تقدم مؤسسة صناع الحياة التدخلات الإنسانية والتنموية لمستفيدين الأكثر احتياجات مع الحفاظ على كرامتهم والتأكد من مشاركتهم. ',
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

  ShowWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 15,
          child: Icon(
            CupertinoIcons.checkmark_alt,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10,
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
