import 'package:flutter/material.dart';
import 'package:uru_bank/components/bottom_modal.dart';
import 'package:uru_bank/components/buttons.dart';
import 'package:uru_bank/model/account_model.dart';
import 'package:uru_bank/model/user_model.dart';
import 'package:uru_bank/routes/app_routes.dart';
import 'package:uru_bank/utils/currency_formatter.dart';
import 'package:uru_bank/utils/styles.dart';
import 'package:uru_bank/views/splash.dart';
import 'package:provider/provider.dart';
import 'package:uru_bank/providers/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  bool _isAccountBalanceVisible = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UrubankUser? user = Provider.of<UserData>(context).user;
    Account account = Account.fromJson(user?.account);

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
            child: Image.asset("assets/images/menu-opener.png", width: 30),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset("assets/images/bell.png", width: 30),
          ),
        ],
      ),
      drawer: drawer(context, user: user!, account: account),
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _accountHeader(
              context,
              accountOwner: user.name.split(' ')[0],
              isAccountBalanceVisible: _isAccountBalanceVisible,
              accountBalance: _isAccountBalanceVisible
                  ? formatCurrency(account.balance)
                  : "*****",
              showAccountBalance: () => setState(
                  () => _isAccountBalanceVisible = !_isAccountBalanceVisible),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _accountActions(context),
            )
          ],
        ),
      ),
    );
  }

  SizedBox _accountActions(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Column(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _accountActionItem(
              context,
              actionTitle: "Transferir",
              actionLeadingIconAsset: "assets/images/Coin.png",
              onActionTap: () =>
                  Navigator.pushNamed(context, AppRoutes.sendMoney),
            ),
            const Divider(),
            _accountActionItem(
              context,
              actionTitle: "Depositar",
              actionLeadingIconAsset: "assets/images/CoinVertical.png",
              onActionTap: () =>
                  Navigator.pushNamed(context, AppRoutes.depositMoney),
            ),
          ],
        ),
      ]),
    );
  }

  ListTile _accountActionItem(
    BuildContext context, {
    required String actionTitle,
    required String actionLeadingIconAsset,
    VoidCallback? onActionTap,
  }) {
    return ListTile(
      tileColor: const Color(0xff262E45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      leading: Image.asset(actionLeadingIconAsset, width: 30),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
        size: 20,
      ),
      iconColor: Colors.white,
      title: Text(
        actionTitle,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'inter',
          fontWeight: FontWeight.w600,
        ),
      ),
      textColor: Colors.white,
      onTap: onActionTap,
    );
  }

  SizedBox _accountHeader(
    BuildContext context, {
    required String accountOwner,
    required String accountBalance,
    VoidCallback? showAccountBalance,
    required bool isAccountBalanceVisible,
  }) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Olá, $accountOwner',
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: "Inter",
            ),
          ),
          SizedBox(
            height: 90,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.accountDetails);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Conta",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      accountBalance,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Inter",
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      onPressed: showAccountBalance,
                      icon: Icon(
                        isAccountBalanceVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawer(
    BuildContext context, {
    required UrubankUser user,
    Account? account,
  }) {
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
                _drawerHeader(
                    account: account ?? Account.fromJson(user.account)),
                _drawerBody(context),
                _drawerFooter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _drawerFooter(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Divider(
                thickness: 3.5,
                color: Color.fromARGB(255, 80, 27, 136),
              ),
            ),
          ),
          _drawerActionItem(
            context,
            actionTitle: 'Sair',
            onTap: () => handleExitApp(context),
          )
        ],
      ),
    );
  }

  void handleExitApp(BuildContext context) {
    showBottomModal(
      context,
      height: 350,
      backgroundColor: Colors.white,
      topBorderRadius: 10,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Você está prestes a sair da sua conta!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Styles.buttonPrimaryColor,
              ),
            ),
            Text(
              "Tem certeza que deseja deslogar deste aparelho?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Styles.appBackgroundColor,
              ),
            ),
            elevatedButton(
              context: context,
              callback: () => Navigator.pop(context),
              borderRadius: 10,
              height: 18,
              color: Styles.buttonPrimaryColor,
              text: "Cancelar",
              textStyle: const TextStyle(
                color: Color(0xffE1E1E6),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(builder: (ctx) => const Splash()),
                  ModalRoute.withName('/'),
                );
              },
              style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent)),
              child: Text(
                "Sair mesmo assim",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Styles.appBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _drawerBody(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          _drawerActionItem(
            context,
            actionTitle: 'Editar perfil',
            onTap: () => Navigator.pushNamed(context, AppRoutes.perfil),
          ),
          _drawerActionItem(
            context,
            actionTitle: 'Configurações',
            onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
        ],
      ),
    );
  }

  ListTile _drawerActionItem(
    BuildContext context, {
    required String actionTitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      iconColor: Colors.white,
      title: Text(
        actionTitle,
        style: const TextStyle(fontSize: 20),
      ),
      textColor: Colors.white,
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }

  SizedBox _drawerHeader({required Account account}) {
    return SizedBox(
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
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: Text(
                  'Agência ${account.agency}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: "Inter",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Conta ${account.number}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: "Inter",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Banco ${account.bank}',
                  style: const TextStyle(
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
    );
  }
}
