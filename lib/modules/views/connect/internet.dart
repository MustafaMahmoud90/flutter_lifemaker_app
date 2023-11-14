import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifemaker/repo/layout/cubit/layout_cubit.dart';

class InternetLost extends StatelessWidget {
  const InternetLost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/offline.gif', // replace with your offline image
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Retry the internet connection check
                BlocProvider.of<LayoutCubit>(context)
                    .checkInternetConnection(context);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15)),
                child: const Text('إعادة المحاولة',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
