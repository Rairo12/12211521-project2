import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2/providers/dashboard_provider.dart';
import 'package:project2/views/berita_panelview.dart';
import 'package:project2/views/peta_view.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panels = [DashboardPanel(), BeritaPanelView(), SizedBox()];

    return Consumer<DashboardProvider>(builder: (context, provider, Widget) {
      return Scaffold(
        bottomNavigationBar: NavigatorBawah(),
        body: panels[provider.indexTombol],
      );
    });
  }
}

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/background.jpg'),
        InformasiPengguna(),
        SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 140),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            margin: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  LabelBerita(),
                  ListBerita(),
                  SizedBox(
                    height: 40,
                  ),
                  Wrap(
                    children: [
                      TombolMenu(
                        image: Image.asset('assets/icon1.png', width: 60),
                      ),
                      TombolMenu(
                        image: Image.asset('assets/icon2.png', width: 60),
                      ),
                      TombolMenu(
                        image: Image.asset('assets/icon3.png', width: 60),
                      ),
                      
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c)=>PetaView(),
                            ),
                          );
                        },
                        child: TombolMenu(
                          image: Image.asset('assets/icon3.png', width: 60),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }
}

class TombolMenu extends StatelessWidget {
  final Image? image;
  const TombolMenu({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(8),
      child: Padding(
          padding: const EdgeInsets.all(18.0), child: image ?? SizedBox()),
    );
  }
}

class ListBerita extends StatelessWidget {
  const ListBerita({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Image.asset(
                'assets/berita1.png',
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Image.asset(
                'assets/berita2.png',
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Image.asset(
                'assets/berita3.png',
                height: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelBerita extends StatelessWidget {
  const LabelBerita({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Align(alignment: Alignment.centerLeft, child: Text('Berita')),
    );
  }
}

class InformasiPengguna extends StatelessWidget {
  const InformasiPengguna({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/profile.png',
              width: 60,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Rafli',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'rafli@gmail.com',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/bell.png',
            width: 40,
          ),
        ],
      ),
    );
  }
}

class NavigatorBawah extends StatelessWidget {
  const NavigatorBawah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = context.read<DashboardProvider>();
    return BottomNavigationBar(
        currentIndex: p.indexTombol,
        onTap: (value) {
          p.saatdiklik(value);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.newspaper), label: 'Berita'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.gear), label: 'Pengaturan'),
        ]);
  }
}
