import 'package:dashboard_wpn/app/auth/pages/auth_main_page.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onIndexChanged;
  const DashboardNavigationWidget(
      {Key? key, required this.selectedIndex, required this.onIndexChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildMenuData(
        {required int index,
        required String title,
        required IconData iconData}) {
      return InkWell(
        onTap: () {
          onIndexChanged(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedIndex == index ? Colors.blue : Colors.transparent,
              border: Border.all(color: Colors.black12)),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 30,
                color: selectedIndex == index ? Colors.white : Colors.black87,
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    color:
                        selectedIndex == index ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.normal),
              ))
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Colors.black12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Selamat Datang,\nAdmin',
            style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView(
            children: [
              _buildMenuData(
                  iconData: Icons.dashboard, index: 0, title: 'Dashboard'),
              SizedBox(
                height: 10,
              ),
              _buildMenuData(
                  iconData: Icons.store, index: 1, title: 'Data Produksi'),
              SizedBox(
                height: 10,
              ),
              _buildMenuData(
                  iconData: Icons.money, index: 2, title: 'Data Pengeluaran'),
              SizedBox(
                height: 10,
              ),
              _buildMenuData(
                  iconData: Icons.sell, index: 3, title: 'Data Penjualan'),
              SizedBox(
                height: 10,
              ),
              _buildMenuData(
                  iconData: Icons.recommend,
                  index: 4,
                  title: 'Rekomendasi Produksi'),
              SizedBox(
                height: 10,
              ),
              _buildMenuData(
                  iconData: Icons.group, index: 5, title: 'Data Karyawan'),
              SizedBox(
                height: 10,
              ),
              _buildMenuData(
                  iconData: Icons.account_circle, index: 6, title: 'Data User'),
            ],
          )),
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              showSnackbar(context,
                  title: 'Berhasil Logout', customColor: Colors.green);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => AuthMainPage()),
                  (route) => false);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  border: Border.all(color: Colors.black12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
