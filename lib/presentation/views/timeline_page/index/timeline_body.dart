// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/all.dart';

// Project imports:
import 'package:uchinoko_project_mobile/application/pets_notifier.dart';
import 'package:uchinoko_project_mobile/application/providers.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/presentation/utils/configuration.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:uchinoko_project_mobile/presentation/views/all/loading_circle.dart';
import 'package:uchinoko_project_mobile/presentation/views/timeline_page/create/post_container.dart';

class TimelineBody extends StatefulWidget {
  @override
  _TimelineBodyState createState() => _TimelineBodyState();
}

class _TimelineBodyState extends State<TimelineBody> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    final size = getScreenSize(context);

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),

            /// Appbar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen
                      ? IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        scaleFactor = 1;
                        isDrawerOpen = false;
                      });
                    },
                  )
                      : IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        setState(() {
                          xOffset = 230;
                          yOffset = 150;
                          scaleFactor = 0.6;
                          isDrawerOpen = true;
                        });
                      }),
                  Column(
                    children: [
                      Text('タイムライン'),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryGreen,
                          ),
                          Text('uchinoko island'),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.title, color: Colors.transparent),
                    onPressed: null,
                  ),
                ],
              ),
            ),

            /// Search window
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text('Search pet to adopt'),
                  Icon(Icons.settings)
                ],
              ),
            ),

            /// ペットカテゴリー
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: index == 0 ? primaryGreen : Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            categories[index]['iconPath'],
                            height: 54,
                            width: 54,
                            color: index == 0 ? Colors.white : Colors.grey[700],
                          ),
                        ),
                        Text(categories[index]['name'])
                      ],
                    ),
                  );
                },
              ),
            ),

            /// 投稿エリア
            Container(
              child: Consumer(
                builder: (context, watch, child) {
                  final state = watch(petsNotifierProvider.state);

                  if (state is PetsInitial) {
                    _fetchPets(context);
                    return _buildLoading(size);
                  } else if (state is PetsLoading) {
                    return _buildLoading(size);
                  } else if (state is PetsLoaded) {
                    return _buildLoaded(state.pets);
                  } else {
                    return _buildInitial();
                  }
                },
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _fetchPets(BuildContext context) {
    context.read(petsNotifierProvider).fetchPets();
  }

  Widget _buildInitial() {
    return Container();
  }

  Widget _buildLoading(Size size) {
    return Center(
      child: Container(
        height: size.height - 120,
        margin: EdgeInsets.only(bottom: 170),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            LoadingCircle(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoaded(List<PetModel> pets) {
    return Column(
      children: [
        PostContainer(
          name: 'にゃんねこ（野良）',
          description:
          '吾輩は猫である。\n名前はまだない。\nどこで生れたか頓（とん）と見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。しかもあとで聞くとそれは書生という人間中で一番獰悪（どうあく）な種族であったそうだ。この書生というのは時々我々を捕（つかま）えて煮て食うという話である。',
        ),
        PostContainer(
          name: 'オードリータン',
          description: '私のすべてを、明るみに出しましょう。私が見ている自由な未来を、皆さんと共有するために',
          petImageUrl:
          'https://images.pexels.com/photos/1404819/pexels-photo-1404819.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          postImageUrl:
          'https://images.pexels.com/photos/1472999/pexels-photo-1472999.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        ),
        PostContainer(
          name: '猫耳族 二等兵',
          petImageUrl:
          'https://images.pexels.com/photos/1576193/pexels-photo-1576193.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          postImageUrl:
          'https://images.pexels.com/photos/1444492/pexels-photo-1444492.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          description:
          '「ネコ耳族」は、相手に攻撃された時に、相手モンスターの元々の攻撃力を200にするモンスター。 装備魔法やフィールド魔法で強化すれば、相手モンスターの攻撃で倒されなくなる',
        ),
      ],
    );
  }
}
