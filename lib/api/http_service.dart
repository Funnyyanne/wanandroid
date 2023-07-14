import 'package:wanandroid/api/api.dart';
import 'package:wanandroid/network/HttpUtil.dart';

class HttpService {
   login(String user, String password)  {
    Map<String, String> data;
    data = {'username': user, 'password': password};
    return  HttpUtil().post(Api.BASE_URL + Api.LOGIN, data:data);
  }

  Future register(String user, String password,String rePassword) async {
    var data;
    data = {'username': user, 'password': password,'repassword':rePassword};
    return await HttpUtil().post(Api.BASE_URL + Api.REGISTER, data: data);
  }

}
