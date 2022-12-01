import 'package:flutter/material.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetails();
}

class _AccountDetails extends State<AccountDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            children: const [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Voltar",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: "Inter",
                  ),
                ),
              )
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 20),
            child: Text(
              "Histórico",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: "Inter",
                letterSpacing: 2,
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .8,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(5),
                          bottom: Radius.circular(5),
                        ),
                        child: VerticalDivider(
                          thickness: 2,
                          width: 20,
                          color: Color.fromARGB(255, 138, 33, 250),
                        ),
                      ),
                    ),
                    Column(
                      children: const [
                        Positioned(
                          child: HistoricItem(
                            title: "22 Jan",
                            info: "Transferência DOC para Cláudia Alves",
                            value: "- 200,00",
                            isDebit: true,
                          ),
                        ),
                        Positioned(
                          child: HistoricItem(
                            title: "29 Nov",
                            info: "Transferência recebida de Lerani Saraiva",
                            value: "600,00",
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoricItem extends StatelessWidget {
  final String title;
  final String info;
  final String value;
  final bool isDebit;

  const HistoricItem({
    Key? key,
    required this.title,
    required this.info,
    required this.value,
    this.isDebit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 156, 71, 247),
                shape: BoxShape.circle),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "Inter",
                      letterSpacing: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      info,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                        color: Colors.white70,
                        fontFamily: "Inter",
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDebit
                      ? const Color.fromARGB(255, 255, 86, 74)
                      : const Color.fromARGB(255, 77, 228, 82),
                  fontFamily: "Inter",
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
