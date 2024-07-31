// import 'dart:ui';

// import 'package:diary_flutter/presentation/journal/journal_body.dart';
// import 'package:diary_flutter/presentation/journal_screen.dart';
// import 'package:diary_flutter/presentation/style/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// class MainBody extends ConsumerWidget {
//   const MainBody({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     const carouselHeight = 490.0;
//     final colors = ref.gemColors;
//     final textStyle = ref.gemTextStyle;
//     return CustomScrollView(
//       physics: const ClampingScrollPhysics(),
//       slivers: [
//         SliverToBoxAdapter(
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//               color: colors.primary100,
//               height: 314,
//               padding: const EdgeInsets.fromLTRB(16, 64, 16, 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Good Evening, Cody",
//                       style: textStyle.paragraph.withColor(colors.grayScale60)),
//                   Text("How was\n your day?", style: textStyle.h1),
//                   const SizedBox(height: 50),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Material(
//                         color: colors.grayScale80,
//                         borderRadius: BorderRadius.circular(
//                             32), // 버튼의 모서리를 둥글게 만듭니다. 필요에 따라 조정하세요.
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(
//                               32), // InkWell의 모서리도 같게 설정합니다.
//                           onTap: () {
//                             context.goNamed(JournalScreen.name,
//                                 queryParameters: {'type': 'chat'});
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 6.0),
//                             child: SizedBox(
//                               height: 31,
//                               width: 130,
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   'Chat to record',
//                                   textAlign: TextAlign.center,
//                                   style: textStyle.paragraph
//                                       .copyWith(color: colors.grayScale0),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Material(
//                         color: colors.grayScale80,
//                         borderRadius: BorderRadius.circular(
//                             32), // 버튼의 모서리를 둥글게 만듭니다. 필요에 따라 조정하세요.
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(
//                               32), // InkWell의 모서리도 같게 설정합니다.
//                           onTap: () {
//                             context.goNamed(JournalScreen.name,
//                                 queryParameters: {'type': 'post'});
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 6.0),
//                             child: SizedBox(
//                               height: 31,
//                               width: 130,
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   'Add a new record',
//                                   textAlign: TextAlign.center,
//                                   style: textStyle.paragraph
//                                       .copyWith(color: colors.grayScale0),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SliverPersistentHeader(
//           pinned: true,
//           delegate: _SliverAppBarDelegate(
//             minHeight: carouselHeight,
//             maxHeight: carouselHeight,
//             child: const CustomHorizontalCarousel(),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Container(
//               height: MediaQuery.of(context).size.height - carouselHeight,
//               color: Colors.red),
//         ),
//       ],
//     );
//   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });

//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   @override
//   double get minExtent => minHeight;

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }

// class CustomHorizontalCarousel extends ConsumerWidget {
//   const CustomHorizontalCarousel({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       height: 490,
//       padding: const EdgeInsets.only(bottom: 20),
//       color: Colors.amber,
//       child: CustomCarousel(
//         depthOrder: DepthOrder.reverse,
//         itemCountBefore: 0,
//         itemCountAfter: 2,
//         alignment: Alignment.bottomCenter,
//         scrollDirection: Axis.horizontal,
//         tapToSelect: false,
//         effectsBuilder: (index, ratio, child) {
//           // print('index: $index, ratio: $ratio');

//           return Transform(
//             transform: Matrix4.identity()
//               ..translate(0.0, -ratio * 127, 0)
//               ..scale(1 - ratio.abs() * 0.2),
//             alignment: Alignment.center,
//             child: Opacity(
//               opacity: 1 - ratio.abs() * 0.2,
//               child: child,
//             ),
//           );
//         },
//         children: List.generate(
//           5,
//           (index) => _buildCard(
//               context,
//               ref,
//               index,
//               "It's Raining, So... — Hazelnut",
//               'https://picsum.photos/200/200?random=$index'),
//         ),
//       ),
//     );
//   }

//   Widget _buildCard(BuildContext context, WidgetRef ref, int index,
//       String title, String? imgUrl) {
//     final colors = ref.gemColors;
//     final textStyle = ref.gemTextStyle;
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Align(
//         child: Container(
//           width: 329,
//           decoration: BoxDecoration(
//             color: colors.grayScale100,
//             borderRadius: BorderRadius.circular(32),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 title,
//                 style: textStyle.caption.withColor(colors.grayScale40),
//               ),
//               const SizedBox(height: 10),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(300),
//                 child: imgUrl != null
//                     ? FutureBuilder<void>(
//                         future: precacheImage(NetworkImage(imgUrl), context),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                                   ConnectionState.done &&
//                               !snapshot.hasError) {
//                             return Image.network(
//                               imgUrl,
//                               width: 250,
//                               height: 250,
//                               fit: BoxFit.cover,
//                             );
//                           } else {
//                             return _buildBlurredCircle(context, ref);
//                           }
//                         },
//                       )
//                     : _buildBlurredCircle(context, ref),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBlurredCircle(BuildContext context, WidgetRef ref) {
//     final colors = ref.gemColors;
//     final textStyle = ref.gemTextStyle;
//     return Container(
//       width: 250,
//       height: 250,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: colors.grayScale60,
//       ),
//       child: ClipOval(
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Container(
//             color: Colors.transparent,
//           ),
//         ),
//       ),
//     );
//   }
// }
