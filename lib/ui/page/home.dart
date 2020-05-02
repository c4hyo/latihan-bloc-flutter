import 'package:bloc_tutorial/bloc/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool max = false;
  ScrollController _scrollController = new ScrollController();
  PostBloc _postBloc;
  int _count = 15;
  int maxData;
  @override
  void initState() {
    _postBloc = BlocProvider.of<PostBloc>(context);
    _postBloc.add(GetListPost());
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        setState(() {
          max = true;
        });
      }else{
        setState(() {
          max = false;
        });
      }
    });
  }
  void _loadMore(){
    _count = _count+15;
    if(_count >= maxData){
      _count = maxData;
    }
    setState(() {
      max =false;
    });
    return _postBloc.add(GetListPost());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        bloc: _postBloc,
        builder: (context, state) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                (max == true)?
                (state is PostWaiting)?LinearProgressIndicator():SizedBox()
                :SizedBox(),
                Expanded(
                  child: Container(
                    color: Colors.green,
                    child:(state is PostLoaded)? ListView.builder(
                      controller: _scrollController,
                      itemCount: _count,
                      itemBuilder: (context,index){
                        maxData = state.listPost.length;
                        return Card(
                          child: ListTile(
                            title: (Text(state.listPost[index].id.toString()+". "+state.listPost[index].title)),
                          )
                        );
                      },
                    ):Center(
                      child:(state is PostError)?Text('Data not Found'):Text('Please wait')
                    ),
                  ),
                ),
                (max == true)?RaisedButton(onPressed: _loadMore,child: Text("Load More"),):SizedBox(),
              ],
            ),
          );
        },
      )
    );
  }

}
