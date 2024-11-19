import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/widgets/image_tile.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var _selectedSliderIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 320,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  PageView.builder(
                      itemCount: 5,
                      onPageChanged: (value) {
                        setState(() {
                          _selectedSliderIndex = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://picsum.photos/500/500?random=slide_$index',
                              fit: BoxFit.cover,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.5),
                                          Colors.black.withOpacity(0.1),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        stops: [0.01, 1])))
                          ],
                        );
                      }),
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Wrap(
                          alignment: WrapAlignment.center,
                          children: List.generate(5, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == _selectedSliderIndex
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            );
                          })))
                ],
              ),
            ),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: SliverAppBar(
              floating: true,
              snap: true,
              title: TextButton.icon(
                onPressed: () {},
                label: Text('Search'),
                icon: Icon(Icons.search_rounded),
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                  iconSize: WidgetStatePropertyAll(24),
                  textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20)),
                ), // ButtonStyle
              ), // TextButton.icon
            ),
          ), // SliverAppBar
        ];
      },
      body: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return ImageTile(
            index: index,
            imageSource: 'https://picsum.photos/500/500?random=img_$index',
            extent: (index % 2) == 0 ? 300 : 150,
          );
        },
      ),
    ));
  }
}
