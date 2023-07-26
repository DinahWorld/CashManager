import 'package:flutter/material.dart';
import '../atomes/carrousel_container.dart';

class Carrousel extends StatefulWidget {
  const Carrousel({Key? key}) : super(key: key);

  @override
  State<Carrousel> createState() => CarrouselState();
}

class CarrouselState extends State<Carrousel> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    final PageController controller = PageController(
      // viewportFraction: 0.4,
      initialPage: 0,
    );

    return Container(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.50,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: buildList(),
              onPageChanged: (page) {
                setState(() {
                  _pageIndex = page;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          threeButton(controller, _pageIndex),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget threeButton(PageController controller, page) {
    final List<Widget> listWidget = [];
    listWidget.add(
      const SizedBox(
        width: 10,
      ),
    );
    for (int i = 0; i != 3; i++) {
      listWidget.add(
        GestureDetector(
          onTap: () {
            controller.jumpToPage(i);
          },
          child: Container(
            decoration: BoxDecoration(
              color: page == i
                  ? const Color.fromARGB(255, 62, 60, 60)
                  : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            height: page == i ? 15 : 10,
            width: page == i ? 15 : 10,
          ),
        ),
      );
      listWidget.add(
        const SizedBox(
          width: 10,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listWidget,
    );
  }

  List<Widget> buildList() {
    final List<Widget> list = [];

    for (int i = 0; i != 3; i++) {
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Center(child: carrousselContainer(context)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Center(child: carrousselContainer(context)),
            ),
          ],
        ),
      );
    }
    return list;
  }
}
