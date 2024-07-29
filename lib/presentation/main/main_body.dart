import 'dart:ui';

import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainBody extends ConsumerWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const carouselHeight = 490.0;
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 260,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Good Evening, Cody",
                      style: context.gemTextStyle.paragraph
                          .withColor(context.gemColors.grayScale60)),
                  Text("How was\n your day?", style: context.gemTextStyle.h1),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: context.gemColors.grayScale80,
                        borderRadius: BorderRadius.circular(
                            32), // 버튼의 모서리를 둥글게 만듭니다. 필요에 따라 조정하세요.
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                              32), // InkWell의 모서리도 같게 설정합니다.
                          onTap: () {
                            print('Calendar');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 6.0),
                            child: SizedBox(
                              height: 31,
                              width: 130,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Chat to record',
                                  textAlign: TextAlign.center,
                                  style: context.gemTextStyle.paragraph
                                      .copyWith(
                                          color: context.gemColors.grayScale0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: context.gemColors.grayScale80,
                        borderRadius: BorderRadius.circular(
                            32), // 버튼의 모서리를 둥글게 만듭니다. 필요에 따라 조정하세요.
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                              32), // InkWell의 모서리도 같게 설정합니다.
                          onTap: () {
                            print('Calendar');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 6.0),
                            child: SizedBox(
                              height: 31,
                              width: 130,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Add a new record',
                                  textAlign: TextAlign.center,
                                  style: context.gemTextStyle.paragraph
                                      .copyWith(
                                          color: context.gemColors.grayScale0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: carouselHeight,
            maxHeight: carouselHeight,
            child: const CustomVerticalCarousel(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
              height: MediaQuery.of(context).size.height - carouselHeight,
              color: Colors.red),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CustomVerticalCarousel extends StatelessWidget {
  const CustomVerticalCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 490,
      padding: const EdgeInsets.only(bottom: 20),
      color: Colors.amber,
      child: CustomCarousel(
        depthOrder: DepthOrder.reverse,
        itemCountBefore: 0,
        itemCountAfter: 2,
        alignment: Alignment.bottomCenter,
        scrollDirection: Axis.vertical,
        tapToSelect: false,
        effectsBuilder: (index, ratio, child) {
          // print('index: $index, ratio: $ratio');

          return Transform(
            transform: Matrix4.identity()
              ..translate(0.0, -ratio * 127, 0)
              ..scale(1 - ratio.abs() * 0.2),
            alignment: Alignment.center,
            child: Opacity(
              opacity: 1 - ratio.abs() * 0.2,
              child: child,
            ),
          );
        },
        children: List.generate(
          5,
          (index) => _buildCard(
              context,
              index,
              "It's Raining, So... — Hazelnut",
              'https://picsum.photos/200/200?random=$index'),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, int index, String title, String? imgUrl) {
    return AspectRatio(
      aspectRatio: 1,
      child: Align(
        child: Container(
          width: 329,
          decoration: BoxDecoration(
            color: context.gemColors.grayScale100,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: context.gemTextStyle.caption
                    .withColor(context.gemColors.grayScale40),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: imgUrl != null
                    ? FutureBuilder<void>(
                        future: precacheImage(NetworkImage(imgUrl), context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              !snapshot.hasError) {
                            return Image.network(
                              imgUrl,
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return _buildBlurredCircle(context);
                          }
                        },
                      )
                    : _buildBlurredCircle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlurredCircle(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.gemColors.grayScale60,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
