import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uru_bank/model/account_model.dart';
import 'package:uru_bank/model/user_model.dart';
import 'package:uru_bank/providers/user.dart';
import 'package:uru_bank/utils/currency_formatter.dart';
import 'package:uru_bank/utils/styles.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetails();
}

class _AccountDetails extends State<AccountDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UrubankUser? user = Provider.of<UserData>(context).user;
    Account account = Account.fromJson(user!.account);
    List<AccountHistory> histories = account.history
        .map((history) => AccountHistory.fromJson(history))
        .toList();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
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
                histories.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          color: Styles.appSecondaryBgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: const [
                            Text(
                              'Você ainda não tem nenhuma movimentação por aqui',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: "Inter",
                              ),
                            ),
                            Divider(),
                            Text(
                              'Faça uma transferência, ou receba um pagamento.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                                fontFamily: "Inter",
                              ),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            child: SizedBox(
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
                          ),
                          Positioned(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: histories.length,
                                itemBuilder: (context, index) {
                                  AccountHistory history = histories[index];

                                  return HistoricItem(
                                    date: history.date,
                                    message: history.message,
                                    value: formatCurrency(history.value),
                                    isDebit: history.type ==
                                        AccountHistoryType.debit,
                                  );
                                },
                              ),
                            ),
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
  final String date;
  final String message;
  final String value;
  final bool isDebit;

  const HistoricItem({
    Key? key,
    required this.date,
    required this.message,
    required this.value,
    this.isDebit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
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
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
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
                      message,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
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
                isDebit ? "- $value" : value,
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
