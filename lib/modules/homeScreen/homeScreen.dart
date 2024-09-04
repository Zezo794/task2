import 'package:flutter/material.dart';

import '../../shared/component/componanets.dart';
import '../favouriteScrren/favouriteScreen.dart';
import '../pdfScreen/pdfScreen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E4C9),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('الصفحة الرئيسية'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: double.infinity, // Set width to take full available space
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,
                  ),
                  onPressed: () {
                    NavigateTo(context, const FavouriteScreen());
                  },
                  child: const Text('الذهاب الي القصائد المفضلة'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity, // Set width to take full available space
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,
                  ),
                  onPressed: () {
                    NavigateTo(context, const PdfViewerPage());
                  },
                  child: const Text('الذهاب الي جميع القصائد'),
                ),
              ),
            ],
          ),
        )

      ),
    );
  }
}


