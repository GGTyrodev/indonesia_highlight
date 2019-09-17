import 'package:flutter/material.dart';
import 'package:indonesia_highlight/ui/widgets/ih_tabbar.dart' as ihtb;
//pages imports
import 'ui/screens/dashboard_screen.dart';
import 'ui/screens/notification_screen.dart';
import 'ui/screens/setting_screen.dart';
import 'ui/screens/explore_screen.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentTab = 0;

  List<Widget> screens;
  Widget currentScreen;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    screens = [
      DashboardPage(), ExplorePage(), NotificationsPage(), SettingsPage()
    ];
    currentScreen  = screens[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Indonesia Highlight'),
      ),
      body: PageStorage(child: currentScreen, bucket: bucket),
      bottomNavigationBar: ihtb.IconTabBar(
          index: 0,
          iconStyle: ihtb.IconStyle(onSelectColor: Colors.red),
          onTap: (i){
            _buildContentView(i);
          },
          items: [
            ihtb.IconTabBarItem(Icons.home),
            ihtb.IconTabBarItem(Icons.search),
            ihtb.IconTabBarItem(Icons.notifications),
            ihtb.IconTabBarItem(Icons.person),
          ],
      ),
    );
  }

  _buildContentView(int i) {
    setState(() {
      currentTab = i;
      currentScreen = screens[i];
    });    
  }
}




