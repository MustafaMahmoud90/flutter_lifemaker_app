import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/modules/views/voating/voters_details.dart';
import 'package:lifemaker/repo/layout/cubit/layout_cubit.dart';

class VotersForDetailScreen extends StatelessWidget {
  const VotersForDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is GetVotersSuccessState) {
          print("تم تحميل المرشحين.");
        } else if (state is GetVotersFaildState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("خطأ في تحميل المرشحين."),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "إنتخابات مجلس إدارة متطوعين",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xff0E395E),
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
              icon: Icon(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                      ),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.voters.length,
                      itemBuilder: (context, index) {
                        final voter = cubit.voters[index];
                        return GestureDetector(
                          onTap: () {
                            final voterId = voter.id.toString();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(e: voter),
                              ),
                            );
                          },
                          child: Container(
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
                                          image: voter.image!,
                                          placeholder:
                                              'assets/user.jpg', // Replace with your placeholder image asset
                                          width:
                                              70, // Adjust the width as needed
                                          height:
                                              70, // Adjust the height as needed
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
                                              voter.name!,
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Icon(
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
      },
    );
  }
}
