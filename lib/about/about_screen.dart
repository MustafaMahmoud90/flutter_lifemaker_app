// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/about/about_det.dart';
import 'package:lifemaker/repo/layout/cubit/layout_cubit.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  List<Map<String, String>> imageData = [
    {
      "image": "https://lifemakers.org/wp-content/uploads/2023/01/team3.jpg",
      "name": "رفيدة محمد ",
      "description":
          "من متطوعي صناع الحياة في محافظة المنوفية وهي مسؤولة ملف دورة حياة المتطوعin.الآن هي المسؤولة عن حفلة “رزق حلال 3” في محافظة المنوفية.وتعمل رفيدة أيضًا كمسؤولة عن مناقشة أبحاث”رزق حلال 3″ في محافظة المنوفية."
    },
    {
      "image": "https://lifemakers.org/wp-content/uploads/2023/01/team2.jpg",
      "name": "يُمنى رفعت ",
      "description":
          "مسؤول مشروع بنك الملابس في المنوفيةinمن متطوعي مؤسسة صناع الحياة مصر بمحافظة المنوفية، منذ عام 2016.inمسؤولة عن مشروع بنك الملابس في المنوفية.inعملت لفترة طويلة بمجال العلاقات العامة لدى المؤسسة، وشاركت في حملات التبرعات بمشروعي رزق حلال ودفا.inتولت يُمنى مسؤولية حملة “دفا 3” في محافظة المنوفية."
    },
    {
      "image": "https://lifemakers.org/wp-content/uploads/2023/01/team1.jpg",
      "name": "محمد فارس ",
      "description":
          "مسؤول البورد المركزي لمحافظة القاهرةinمحمد فارس 26 عامًا، حصل فارس على بكالوريوس هندسة قسم القوى والآلات الكهربائية من جامعة حلوان, يعمل -حاليًا- مهندس كهرباء.inالتحق بصناع الحياة مصر فى شهر سبتمبر عام 2012.inمارس أكثر من دور بمؤسسة صناع الحياة حتى أصبح مسؤول منطقة، أصبح -الآن- مسؤولًا عن البورد المركزي لمحافظة القاهرة.inيرى أن التطوع عمل يحقق له الكثير؛ وأهم ما يحققه هذا العمل النبيل هو الاستمتاع وإرضاء الله."
    },
    {
      "image": "https://lifemakers.org/wp-content/uploads/2023/01/team6.jpg",
      "name": "فاطمة إبراهيم ",
      "description":
          "واحدة من أنشط المتطوعين لدى مؤسسة صناع الحياة مصر ومن أكثرهم تأثيرًا.inانضمت إلى متطوعي مؤسسة صناع الحياة، بالتزامن مع نشأة الفكرة خلال عام 2004.inشاركت كمتطوعة بأنشطة صناع الحياة المختلفة مثل حملة جمع الملابس، شنطة رمضان، التوعية الصحية عن مخاطر السمنة، حملة “حماية” للتوعية ضد التدخين والمخدرات، القوافل الطبية، أسرة صناع الحياة بالجامعة، خلال الفترة (2004 – 2010).inشاركت كمتطوعة بمبادرة محو الأمية ثم كمسئول فتح فصول ثم كمشرف لمتابعة 7 فصول، ثم مدرب على منهج صناع الحياة لمحو الأمية، ثم كمنسق لجنة التدريب والمناهج ثم كمنسق لجنة الامتحانات، خلال الفترة (2011 – 2013)."
    },
    {
      "image": "https://lifemakers.org/wp-content/uploads/2023/01/team5.jpg",
      "name": "أمنية عبدالكريم ",
      "description":
          "تخرجت من كلية صيدلة، وهي من مؤسسي صناع الحياة مصر في السويس.inكانت متطوعة في مشروع حماة المستقبل ومسؤولة حملة “اوعى” ومنسقة صناع الحياة السويس منذ عام 2016 حتى 2018inعملت أمينة كمسؤولة تمويل مشروع رزق حلال 1، ورزق حلال 2، ومركب واحدة، وحققت المحافظة نتائج مبهرةinتعمل -حاليًا- كمنسقة قطاع القناة وعضو مجلس ادارة جمعية رواد صناع الحياة السويس"
    },
    {
      "image": "https://lifemakers.org/wp-content/uploads/2023/01/team4.jpg",
      "name": " سيف ثروت ",
      "description":
          "مسؤول مكتب صناع الحياة بمحافظة الشرقيةinسيف من متطوعي صناع الحياة مصر في محافظ الشرقية.inيعمل سيف كمسؤول مكتب؛ يرتب ونظم المهام في المركز وشارك في توظيف المتطوعين.inأصبح مسؤولًا عن أبحاث مشاريع “مركب واحد” في محافظة الشرقية، وكون فريق للأبحاث من المتطوعين وتدريبهم على آلية العمل."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "قصص نجاح المتطوعيين",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xff0E395E),
          ),
        ),
        centerTitle: true,
        scrolledUnderElevation: 10,
        shadowColor: Colors.black,
        excludeHeaderSemantics: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: const Color(0xff0E395E),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.arrow_right,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),
        ),
        child: RefreshIndicator(
          backgroundColor: const Color(0xffE9791E),
          color: const Color.fromARGB(255, 255, 255, 255),
          onRefresh: () async {
            cubit.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                  ),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: imageData.length,
                  itemBuilder: (context, index) {
                    final voter = cubit.voters[index];
                    return GestureDetector(
                      onTap: () {
                        // final voterId = voter.id.toString();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AboutDetails(
                              imageData: imageData[index],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Hero(
                          tag: voter.id!,
                          child: Card(
                            color: const Color(0xff0E395E),
                            clipBehavior: Clip.hardEdge,
                            elevation: 20, // Adjust the elevation as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: FadeInImage.assetNetwork(
                                      image: imageData[index]['image']!,
                                      placeholder:
                                          'assets/user.jpg', // Replace with your placeholder image asset
                                      width: 70, // Adjust the width as needed
                                      height: 70, // Adjust the height as needed
                                      fit: BoxFit
                                          .cover, // Adjust the BoxFit as needed
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          imageData[index]['name']!,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        CupertinoIcons.info_circle_fill,
                                        color: Colors
                                            .white, // You can change the color as needed
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
