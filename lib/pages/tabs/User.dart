import 'package:flutter/material.dart';
import 'package:flutter_jd/services/EventBus.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/UserServices.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isLogin = false;
  List _userInfo = [];
  var actionEventBus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserInfo();

    actionEventBus = eventBus.on<UserEvent>().listen((event) {
      print(event);
      _getUserInfo();
    });
  }

  //当组件销毁时取消事件监听
  void dispose() {
    super.dispose();

    actionEventBus.cancel();
  }

  _getUserInfo() async{
    bool isLogin = await UserServices.getUserState();
    List userInfo = await UserServices.getUserInfo();

    setState(() {
      _isLogin = isLogin;
      _userInfo = userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('用户中心'),
      // ),
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenAdapter.height(220),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/user_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipOval(
                    child: Image.asset(
                      'images/user.png',
                      fit: BoxFit.cover,
                      width: ScreenAdapter.width(100),
                      height: ScreenAdapter.height(100),
                    )
                  ),
                ),
                _isLogin
                ?Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('用户名： ${_userInfo[0]['username']}', style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdapter.size(32),
                      )),
                      Text('普通会员', style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdapter.size(24),
                      )),
                    ],
                  ),
                )
                :Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('登录/注册', style: TextStyle(
                      color: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Colors.red),
            title: Text('全部订单'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text('待付款'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_car_wash, color: Colors.orange),
            title: Text('待收货'),
          ),

          Container(
            width: double.infinity,
            height: 10,
            color: Color.fromRGBO(242, 242, 242, 0.9),
          ),

          ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightGreen),
            title: Text('我的收藏'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people, color: Colors.black54),
            title: Text('在线客服'),
          ),
          
          _isLogin
          ?Container(
            width: double.infinity,
            height: 10,
            color: Color.fromRGBO(242, 242, 242, 0.9),
          )
          :Divider(),

          _isLogin
          ?ListTile(
            leading: Icon(Icons.logout, color: Colors.brown),
            title: Text('退出登录'),
            onTap: (){
              UserServices.logout();
              _getUserInfo();
            },
          )
          :Text(''),
          _isLogin ? Divider() : Text(''),
        ],
      ),
    );
  }
}