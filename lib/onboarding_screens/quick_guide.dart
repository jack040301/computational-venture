import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:main_venture/screens/home_page.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  List imageList = [
    {"id": 1, "image_path": "assets/images/icons/Welcome.png"},
    {"id": 2, "image_path": "assets/images/icons/1TapAnywhere.png"},
    {"id": 3, "image_path": "assets/images/icons/2PinnedLocDisplay.png"},
    {"id": 4, "image_path": "assets/images/icons/3PinnedLoc.png"},
    {"id": 5, "image_path": "assets/images/icons/4PinnedLoc.png"},
    {"id": 6, "image_path": "assets/images/icons/5PinnedLoc.png"},
    {"id": 7, "image_path": "assets/images/icons/6PinnedLoc.png"},
    {"id": 8, "image_path": "assets/images/icons/7PinnedLoc.png"},
    {"id": 9, "image_path": "assets/images/icons/8PinnedLoc.png"},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 242, 242),
      // appBar: AppBar(
      // backgroundColor: Colors.transparent,
      // title: const Text('Quick Guide'),
      // foregroundColor: const Color.fromARGB(255, 44, 45, 48),
      // elevation: 0.0,
      // leading: const BackButton(
      // color: Color.fromARGB(255, 44, 45, 48),
      // ),
      //   ),
      body: Column(children: [
        const SizedBox(
          height: 1.0,
        ),
        Stack(
          children: [
            InkWell(
              onTap: () {
                print(currentIndex);
              },
              child: CarouselSlider(
                items: imageList
                    .map(
                      (item) => Image.asset(
                    item['image_path'],
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                )
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  height: 759,
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  //  enlargeCenterPage: true,
                  aspectRatio: 5,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            //Dots
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 17 : 7,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentIndex == entry.key
                              ? Colors.blue
                              : Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
            RawMaterialButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const HomePage())),
              child: const Text("SKIP",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 110, 195),
                      fontSize: 14.0)),
            ),
          ],
        ),
      ]),
    );
  }
}