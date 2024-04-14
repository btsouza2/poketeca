import 'package:flutter/material.dart';
import 'package:poketeca/common/features/pokedex/screens/details/pages/detail_list_widget.dart';
import '../../../../../models/pokemon.dart';
import 'detail_TabBar_Widget.dart';
import 'detail_appbar_widget.dart';

class DetailPage extends StatefulWidget {
  DetailPage(
      {super.key,
      required this.pokemon,
      required this.list,
      required this.onBack,
      required this.controller,
      required this.onChagePokemon});
  final Pokemon pokemon;
  final List<Pokemon> list;
  final VoidCallback onBack;
  final PageController controller;
  final ValueChanged<Pokemon> onChagePokemon;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ScrollController scrollController;
  bool isOnTop = false;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (notification) {
          setState(
            () {
              if (scrollController.position.pixels > 37) {
                isOnTop = false;
              } else if (scrollController.position.pixels <= 36) {
                isOnTop = true;
              }
            },
          );
          return false;
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            DetailAppBarWidget(
              pokemon: widget.pokemon,
              onBack: widget.onBack,
              isOnTop: isOnTop,
            ),
            DetailListWidget(
              pokemon: widget.pokemon,
              list: widget.list,
              controller: widget.controller,
              onChagePokemon: widget.onChagePokemon,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      color: widget.pokemon.baseColor,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.only(top: 20),
                        child:  DetailTabBarWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}