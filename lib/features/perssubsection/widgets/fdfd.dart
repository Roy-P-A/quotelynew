import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// class MyCarouselSlider extends StatefulWidget {
//   @override
//   _MyCarouselSliderState createState() => _MyCarouselSliderState();
// }

// class _MyCarouselSliderState extends State<MyCarouselSlider> {
//   int selectedCenterIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carousel Slider'),
//       ),
//       body: Container(
//         color: Colors.yellow,
//         height: 150,
//         child: CarouselSlider.builder(
//           itemCount: 10,
//           itemBuilder: (BuildContext context, int index, int realIndex) {
//             return Center(
//               child: Container(
//                 width: 45.0,
//                 height: 45.0,
//                 decoration: BoxDecoration(
//                   color: index == selectedCenterIndex
//                       ? Colors.blue
//                       : Colors.red,
//                   borderRadius: BorderRadius.circular(40.0),
//                   border: Border.all(
//                     color: Colors.blue,
//                     width: index == selectedCenterIndex ? 2.0 : 0.0,
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Item $index',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//           options: CarouselOptions(
//             height: 150,
//             viewportFraction: 0.3,
//             enlargeCenterPage: true,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 selectedCenterIndex = index;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyCarouselSlider extends StatefulWidget {
//   @override
//   _MyCarouselSliderState createState() => _MyCarouselSliderState();
// }

// class _MyCarouselSliderState extends State<MyCarouselSlider> {
//   int selectedCenterIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.transparent,
//         height: 100,
//         child: CarouselSlider.builder(
//           itemCount: 10,
//           itemBuilder: (BuildContext context, int index, int realIndex) {
//             double scaleFactor = index == selectedCenterIndex ? 1 : 1.0;
//             return Center(
//               child: Container(
//                 width: 45.0 ,
//                 height: 45.0 ,
//                 // width: 45.0 * scaleFactor,
//                 // height: 45.0 * scaleFactor,
//                 decoration: BoxDecoration(
//                   color: index == selectedCenterIndex
//                       ? Colors.white.withOpacity(0.4)
//                       : Colors.white.withOpacity(0.4),
//                   borderRadius: BorderRadius.circular(40.0),
//                   border: Border.all(
//                     color: Colors.white,
//                     width: index == selectedCenterIndex ? 2.0 : 0.0,
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     '$index',
//                     style: TextStyle(
//                       fontSize: 16.0 * scaleFactor,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//           options: CarouselOptions(
//             height: 150,
//             viewportFraction: 0.2,
//             enlargeCenterPage: true,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 selectedCenterIndex = index;
//               });
//             },
//           ),
//         ),
//       );
    
//   }
// }
