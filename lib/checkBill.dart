import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ownerapp/ownerComment.dart';
import 'package:ownerapp/ownerLogin.dart';

class CheckBill extends StatefulWidget {
  final User user;

  const CheckBill({Key key, this.user}) : super(key: key);

  @override
  _CheckBillState createState() => _CheckBillState();
}

class _CheckBillState extends State<CheckBill> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffEED9B9),
        iconTheme: IconThemeData(color: Color(0xff623B28)),
        //automaticallyImplyLeading: ,
        centerTitle: true,
        title: Text("Manager",
            style: TextStyle(color: Color(0xff623B28),fontWeight: FontWeight.bold),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore.collection("getOrder").snapshots(),
       builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> querySnapshot) {
              if(querySnapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
              }
              else{
                final list = querySnapshot.data.docs;
                return new ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckBill()));
                        },
                   child: Container(                       
                        height: 80.0,
                        width: 40.0,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                            
                              Padding(padding: EdgeInsets.only(left:20.0),
                                child: Text("User:${list[index].data()["User"]}",
                                          style: TextStyle(color: Color(0xff623B28),
                                          fontWeight: FontWeight.bold, fontSize: 16.0)),
                              ), 

                            ]
                            ),
                              Padding(padding: EdgeInsets.only(left:20.0),
                                child: Container(
                                  child: Text("Date&Time:${list[index].data()["Total"]}",
                                            style: TextStyle(color: Color(0xff623B28),
                                            fontWeight: FontWeight.bold, fontSize: 16.0)),
                                ),
                              ),
                          ]
                        ),          
                      )
                    );
                     
                  },
                );
              }
        },
      )
    );
  }
  Future _signOut() async {
    await _auth.signOut();
  }
}

