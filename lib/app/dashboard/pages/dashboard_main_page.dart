import 'package:dashboard_wpn/app/dashboard/pages/main_dashboard_page.dart';
import 'package:dashboard_wpn/app/dashboard/widgets/dashboard_navigation_widget.dart';
import 'package:dashboard_wpn/app/dashboard/widgets/dashboard_topbar_widget.dart';
import 'package:dashboard_wpn/app/karyawan/karyawan_main_page.dart';
import 'package:dashboard_wpn/app/kpi/kpi_main_page.dart';
import 'package:dashboard_wpn/app/pendapatan/pendapatan_main_page.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_main_page.dart';
import 'package:dashboard_wpn/app/production/production_main_page.dart';
import 'package:dashboard_wpn/app/rekomendasi/rekomendasi_produksi_page.dart';
import 'package:dashboard_wpn/app/user/user_main_page.dart';
import 'package:flutter/material.dart';

class DashboardMainPage extends StatefulWidget {
  const DashboardMainPage({Key? key}) : super(key: key);

  @override
  State<DashboardMainPage> createState() => _DashboardMainPageState();
}

class _DashboardMainPageState extends State<DashboardMainPage> {
  int selectedIndex = 0;

  List<Widget> dataScreen = [
    MainDashboardPage(),
    ProductionMainPage(),
    PengeluaranMainPage(),
    PendapatanMainPage(),
    RekomendasiProduksiPage(),
    KaryawanMainPage(),
    UserMainPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: DashboardNavigationWidget(
              selectedIndex: selectedIndex,
              onIndexChanged: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Flexible(
              flex: 8,
              child: Column(
                children: [
                  DashboardTopbarWidget(),
                  Expanded(child: dataScreen[selectedIndex])
                ],
              ))
        ],
      ),
    );
  }
}
