import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:newmatrimony_api/add_user.dart';
import 'package:newmatrimony_api/model/usermodel.dart';
import 'package:newmatrimony_api/remote_service.dart';

class FemaleListPage extends StatefulWidget {
  @override
  State<FemaleListPage> createState() => _FemaleListPage();
}

class _FemaleListPage extends State<FemaleListPage> {
  List<UserModel> localList = [];
  List<UserModel> searchList = [];
  bool isGetData = true;
  var isdata = false;
  FocusNode myFocusNode = new FocusNode();
  TextEditingController controller = TextEditingController();
  bool _isFavorited = true;

  @override
  void initState() {
    super.initState();
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
              margin: EdgeInsets.only(left: 100),
              padding: EdgeInsets.only(left: 10),
              height: 70,
              width: 70,
              child: Tab(
                  icon: new Image.asset(
                    "assets/images/marriage.png",
                  )))),
      body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.awesomePine,
                        begin: Alignment.topLeft)),
                child: Container(),
              ),
              FutureBuilder<List<UserModel>?>(
                  builder: (context, snapshot) {
                    if (snapshot != null && snapshot.hasData) {
                      if (isGetData) {
                        localList.addAll(snapshot.data!);
                        searchList.addAll(localList);
                      }
                      isGetData = false;
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                  colors: GradientColors.darkPink,
                                  begin: Alignment.topLeft),
                            ),
                            child: TextField(
                              focusNode: myFocusNode,
                              decoration: InputDecoration(
                                labelText: "Search Users",
                                labelStyle: TextStyle(
                                    color: myFocusNode.hasFocus
                                        ? Colors.white
                                        : Colors.white),
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                                enabledBorder: myinputborder(),
                              ),
                              controller: controller,
                              onChanged: (value) {
                                searchList.clear();
                                for (int i = 0; i < localList.length; i++) {
                                  if (localList[i]
                                      .userName!
                                      .toLowerCase()
                                      .contains(value)) {
                                    searchList.add(localList[i]);
                                  }
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.all(5),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          AddUser(model: searchList![index]),
                                    ));
                                  },
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
                                                            if (searchList![index]
                                                                .favUser ==
                                                                'false') {
                                                              searchList![index]
                                                                  .favUser = 'true';
                                                            } else if (searchList![
                                                            index]
                                                                .favUser ==
                                                                'true') {
                                                              searchList![index]
                                                                  .favUser = 'false';
                                                            }
                                                            RemoteService().updateFavUser(userId: searchList[index].id.toString(),favUser:  searchList[index].favUser);
                                                          });
                                                        },
                                                        child: Icon(
                                                          searchList![index].favUser ==
                                                              'true'
                                                              ? Icons.favorite
                                                              : Icons
                                                              .favorite_border_outlined,
                                                          color: Colors.red,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                          EdgeInsets.only(left: 10),
                                                          child: Image.network(
                                                            searchList![index]
                                                                .images
                                                                .toString(),
                                                            height: 130,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          searchList![index]
                                                              .userName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors.redAccent,
                                                              fontSize: 30),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          searchList![index]
                                                              .dob
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                              Colors.grey.shade500,
                                                              fontSize: 20),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                            'Mobile no: ${searchList![index].mobileno.toString()}',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors.white)),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.only(left: 25),
                                                          child: Container(
                                                            margin: EdgeInsets.only(
                                                                right: 20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text('Gender',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                            20)),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    Text(
                                                                      searchList[index]
                                                                          .gender
                                                                          .toString() ==
                                                                          "1"
                                                                          ? "Male"
                                                                          : searchList[index]
                                                                          .gender
                                                                          .toString() ==
                                                                          "2"
                                                                          ? "Female"
                                                                          : "Other",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
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
                                                          margin:
                                                          EdgeInsets.only(left: 50),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 70),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      'Delete User',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize: 20),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        showDialog(
                                                                            context:
                                                                            context,
                                                                            builder:
                                                                                (BuildContext
                                                                            contex) {
                                                                              return AlertDialog(
                                                                                title: Text(
                                                                                    "Delete"),
                                                                                content:
                                                                                Text("Do you want to delete this record"),
                                                                                actions: [
                                                                                  Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment.center,
                                                                                    crossAxisAlignment:
                                                                                    CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      ElevatedButton(
                                                                                        onPressed: () async {
                                                                                          var id = searchList![index].id;
                                                                                          var deletedUserID = await RemoteService().delete('/Matrimony/$id');
                                                                                          // if (deletedUserID > 0) {
                                                                                          //   searchList!.removeAt(index);
                                                                                          // }
                                                                                          setState(() {
                                                                                            searchList.removeAt(index);
                                                                                            localList.removeAt(index);
                                                                                            Navigator.of(context).pop();
                                                                                          });
                                                                                        },
                                                                                        child: Text("Delete"),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      ElevatedButton(
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                        child: Text("No"),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              );
                                                                            });
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .delete_rounded,
                                                                        color:
                                                                        Colors.red,
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
                              },
                              itemCount: searchList!.length,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return (Center(
                        child: CircularProgressIndicator(color: Colors.pink,),
                      ));
                    }
                  },
                  future: isGetData ? RemoteService().getFemaleUser() : null),
            ],
          )),
    ));
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
