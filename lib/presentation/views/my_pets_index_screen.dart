import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uchinoko_project_mobile/application/pets_notifier.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:uchinoko_project_mobile/presentation/views/configuration.dart';
import 'package:uchinoko_project_mobile/presentation/views/drawerScreen.dart';
import 'package:uchinoko_project_mobile/presentation/views/loading_circle.dart';
import 'package:uchinoko_project_mobile/providers.dart';

class MyPetsIndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          _Screen(),
        ],
      ),
    );
  }
}

class _Screen extends StatefulWidget {
  @override
  __ScreenState createState() => __ScreenState();
}

class __ScreenState extends State<_Screen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  void initState() {
    print("init State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                height: 120,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Location'),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryGreen,
                            ),
                            Text('Ukraine'),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          "https://user-images.githubusercontent.com/46050182/100489814-01167a00-315a-11eb-885b-2156062cc5bf.png"),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  "うちの子 一覧",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              Container(
                height: size.height - 170,
                child: Consumer(
                  builder: (context, watch, child) {
                    final state = watch(petsNotifierProvider.state);

                    if (state is PetsInitial) {
                      _fetchPets(context);
                      return _buildLoading();
                    } else if (state is PetsLoading) {
                      return _buildLoading();
                    } else if (state is PetsLoaded) {
                      return _buildLoaded(state.pets);
                    } else {
                      return _buildInitial();
                    }
                  },
                ),
              ),
            ],
          ),
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

  Widget _buildLoading() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 170),
        child: LoadingCircle(),
      ),
    );
  }

  Widget _buildLoaded(List<PetModel> pets) {
    return ListView.separated(
      itemCount: pets.length,
      itemBuilder: (context, index) {
        return PetTile(pet: pets[index]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

class PetTile extends StatelessWidget {
  const PetTile({@required this.pet}) : super();

  final PetModel pet;

  @override
  ListTile build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
      leading: CircleAvatar(
        backgroundColor: primaryGreen,
        backgroundImage: NetworkImage(pet.imagePath),
        radius: 36,
      ),
      title: Text(pet.name),
      subtitle: Text(
        "スコティッシュ・フォールド",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        child: "male" == pet.sex
            ? Icon(
                FontAwesomeIcons.mars,
                size: 32,
                color: Colors.blueAccent,
              )
            : Icon(
                FontAwesomeIcons.venus,
                size: 32,
                color: Colors.redAccent,
              ),
      ),
    );
  }
}
