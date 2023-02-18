import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:newmatrimony_api/model/usermodel.dart';
import 'package:newmatrimony_api/remote_service.dart';

class MaleUserList extends StatefulWidget {
  @override
  State<MaleUserList> createState() => _UserList();
}

class _UserList extends State<MaleUserList> {
  List<UserModel>? localList = [];
  List<UserModel>? searchList = [];
  var isdata = false;
  bool isGetData = true;
  FocusNode myFocusNode = new FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  apiCall() async {
    localList = await RemoteService().getPosts();
    if (localList != null) {
      setState(() {
        isdata = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, // <-- SEE HERE
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: GradientColors.freshMilk, begin: Alignment.topLeft),
              ),
            ),
            elevation: 10,
            title: Container(
                margin: EdgeInsets.only(left: 150),
                padding: EdgeInsets.only(left: 10),
                height: 70,
                width: 70,
                child: Tab(
                    icon: new Image.asset(
                      "assets/images/marriage.png",
                    )))),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: GradientColors.awesomePine,
                      begin: Alignment.topLeft)),
              child: Container(),
            ),
            Visibility(
              visible: isdata,
              child: ListView.builder(
                padding: EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  if(localList![index].gender ==1 )
                    {
                      return InkWell(
                        // onTap: () {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         AddUser(model: localList![index]),
                        //   ));
                        // },
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color.fromRGBO(77, 13, 51, 1.0),
                            elevation: 5,
                            borderOnForeground: true,
                            child: (Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(55),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (localList![index].favUser == false) {
                                                    localList![index].favUser = true;
                                                  } else if (localList![index].favUser ==
                                                      true) {
                                                    localList![index].favUser = false;
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                localList![index].favUser == true
                                                    ? Icons.favorite
                                                    : Icons.favorite_border_outlined,
                                                color: Colors.red,
                                                size: 50,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              // Container(
                                              //   margin: EdgeInsets.only(left: 10),
                                              //   child: Image.asset(
                                              //     localList![index].gender as int == 1
                                              //         ? "assets/images/groom.png"
                                              //         : localList![index].gender as int ==
                                              //                 2
                                              //             ? "assets/images/bride.png"
                                              //             : "assets/images/couple.png",
                                              //     height: 60,
                                              //     width: 60,
                                              //   ),
                                              // ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                localList![index].userName.toString(),
                                                style: TextStyle(
                                                    color: Colors.redAccent, fontSize: 30),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                localList![index].dob.toString(),
                                                style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                  'Mobile no: ${localList![index].mobileno.toString()}',
                                                  style: TextStyle(
                                                      fontSize: 20, color: Colors.white)),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left: 25),
                                                child: Container(
                                                  margin: EdgeInsets.only(right: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text('Gender',
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 20)),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            localList![index].gender
                                                            as int ==
                                                                1
                                                                ? "Male"
                                                                : localList![index].gender
                                                            as int ==
                                                                2
                                                                ? "Female"
                                                                : "Other",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 50),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 70),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Delete User',
                                                            style: TextStyle(
                                                                color: Colors.red,
                                                                fontSize: 20),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext
                                                                  contex) {
                                                                    return AlertDialog(
                                                                      title: Text("Delete"),
                                                                      content: Text(
                                                                          "Do you want to delete this record"),
                                                                      actions: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                          children: [
                                                                            ElevatedButton(
                                                                              onPressed:
                                                                                  () async {
                                                                                // int deletedUserID = await db.deleteUserFromUserTable(localList[index].UserID);
                                                                                // if (deletedUserID > 0) {
                                                                                //   localList.removeAt(index);
                                                                                // }
                                                                                // ;
                                                                                // setState(() {
                                                                                //   Navigator.push(context, MaterialPageRoute(builder: (context) => UserList()));
                                                                                // });
                                                                              },
                                                                              child: Text(
                                                                                  "Delete"),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            ElevatedButton(
                                                                              onPressed:
                                                                                  () {
                                                                                Navigator.of(
                                                                                    context)
                                                                                    .pop();
                                                                              },
                                                                              child: Text(
                                                                                  "No"),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                            },
                                                            child: Icon(
                                                              Icons.delete_rounded,
                                                              color: Colors.red,
                                                              size: 30,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Icon(
                                    Icons.keyboard_arrow_right_outlined,
                                    color: Colors.grey.shade400,
                                    size: 24,
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      );
                    }
                  else {
                    return Container();
                  }
                },
                itemCount: localList!.length,
              ),
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        )));
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
      //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 3,
        ));
  }
}
