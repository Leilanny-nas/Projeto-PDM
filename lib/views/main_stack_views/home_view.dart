import 'package:flutter/material.dart';
import 'package:uru_bank/routes/app_routes.dart';
import 'package:uru_bank/utils/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.isDrawerOpen
                  ? _scaffoldKey.currentState!.closeDrawer()
                  : _scaffoldKey.currentState!.openDrawer();
            },
            child: Image.asset(
              "assets/images/menu-opener.png",
              width: 30,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              "assets/images/bell.png",
              width: 30,
            ),
          ),
        ],
      ),
      drawer: drawer(context),
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Olá, Lerani',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: "Inter",
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Conta",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.accountDetails);
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Text(
                          '0,00',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "Inter",
                          ),
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: 300,
                                height: 64,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff262E45),
                                        width: 4.0,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff262E45)),
                                child: const Text(
                                  "Transferir",
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: "Inter"),
                                ),
                              ),
                            ),
                            const Divider(),
                            Center(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: 300,
                                height: 64,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff262E45),
                                        width: 4.0,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff262E45)),
                                child: const Text(
                                  "Depositar",
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: "Inter"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      backgroundColor: Styles.appSecondaryBgColor.withOpacity(1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: DrawerHeader(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: const Color(0xff9747FF).withOpacity(.25),
                    ),
                    child: Container(
                      height: double.infinity,
                      decoration: const BoxDecoration(color: Color(0xff5F249F)),
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Image.asset(
                              "assets/images/user-focus.png",
                              width: 50,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 5),
                            child: Text(
                              'Agência 0000',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Inter",
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Conta 0000000-0',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Inter",
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Banco 0000',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "Inter",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ListTile(
                        iconColor: Colors.white,
                        title: const Text(
                          'Editar perfil',
                          style: TextStyle(fontSize: 20),
                        ),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        iconColor: Colors.white,
                        title: const Text(
                          'Configurações',
                          style: TextStyle(fontSize: 20),
                        ),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Divider(
                            color: Color.fromARGB(255, 80, 27, 136),
                          ),
                        ),
                      ),
                      ListTile(
                        iconColor: Colors.white,
                        title: const Text(
                          'Sair',
                          style: TextStyle(fontSize: 20),
                        ),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.splash);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
