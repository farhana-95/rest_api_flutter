import 'package:flutter/material.dart';
import 'package:rest_api_flutter/services/call_data.dart';

import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    //fetch data from api
    getData();
  }
  getData()async{
    posts = await CallData().getPosts();
    if(posts != null)
      {
        setState(() {
          isLoaded = true;
        });
      }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black38,
      appBar:AppBar(title: Center(child: Text('Posts',style: TextStyle(color: Colors.black),),),backgroundColor: Colors.white,),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Text('Title: ${posts![index].title}',style: TextStyle(fontWeight: FontWeight.bold,),)),
                    Container(
                      margin: EdgeInsets.all(15),
                        child: Text('Body: ${posts![index].body}'))
                  ],
                ),
              );

        }),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
