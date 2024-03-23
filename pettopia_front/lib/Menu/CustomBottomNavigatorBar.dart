import 'package:flutter/material.dart';

class CustomBottomNavigatorBar extends StatefulWidget {
  final int page; 


  const CustomBottomNavigatorBar({Key? key, required this.page, }) : super(key: key);

  @override
  _CustomBottomNavigatorBarState createState() => _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //미용관리
          IconButton(
            onPressed: () {
              // if (widget.page != 0) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const MyApp()),
              //   );
              // }
            },
            icon: Icon(Icons.content_cut),
            color: widget.page == 0 ? Color.fromARGB(255, 0, 22, 64) : Colors.grey,
          ),
          //병원관리
          IconButton(
            onPressed: () {
              // if (widget.page != 1) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ViewTicket(myTeam: widget.myTeam,)),
              //   );
              // }
            },
            icon: Icon(Icons.local_hospital),
            color: widget.page == 1 ? Color.fromARGB(255, 0, 22, 64) : Colors.grey,
          ),
          //홈
          IconButton(
            onPressed: () {
              // if (widget.page != 2) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => WinningMain(myTeam: widget.myTeam,)),
              //   );
              // }
            },
            icon: Icon(Icons.home),
            color: widget.page == 2 ? Color.fromARGB(255, 0, 22, 64) : Colors.grey,
          ),
          //라이프관리
           IconButton(
            onPressed: () {
              // if (widget.page != 2) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => WinningMain(myTeam: widget.myTeam,)),
              //   );
              // }
            },
            icon: Icon(Icons.list),
            color: widget.page == 2 ? Color.fromARGB(255, 0, 22, 64) : Colors.grey,
          ),
          //설정
           IconButton(
            onPressed: () {
              // if (widget.page != 2) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => WinningMain(myTeam: widget.myTeam,)),
              //   );
              // }
            },
            icon: Icon(Icons.settings),
            color: widget.page == 2 ? Color.fromARGB(255, 0, 22, 64) : Colors.grey,
          ),
        ],
      ),
    );
  }
}
