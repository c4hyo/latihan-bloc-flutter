import 'package:bloc_tutorial/model/login.dart';
import 'package:bloc_tutorial/model/post.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  Dio dio = Dio();
  Response response;

  Future<List<Post>> getListPost() async{
    try{
      response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      List listResponse = response.data;
      List<Post> listPost = listResponse.map((f)=> Post.fromJson(f)).toList();
      return listPost;
    }catch(e){
      throw Exception;
    }
  }
  Future<LoginModel> login(LoginModel loginData) async{
    try{
      response = await dio.post("https://reqres.in/api/login",data:loginData.toJson()).catchError((onError){
        print("Error");
      });
      var loginResponse = response.data;
      LoginModel loginModel = LoginModel.fromJson(loginResponse);
      return loginModel;
    }on DioError catch(e){
      if(e.type == DioErrorType.RESPONSE){
        if(e.response.statusCode == 400){
          throw Exception("eror");
        }
        throw Exception("Pengguna tidak ditemukan");
      }
      throw Exception("eroro");
    }
  }
  
}