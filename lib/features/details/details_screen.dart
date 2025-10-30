import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDetailsPage extends StatelessWidget {
  const MyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/movie_poster.png",
                width: double.infinity,
                height: 457.h,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Movie Title",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            
                          },
                          icon: Icon(
                            Icons.favorite_outline,
                            size: 33.sp,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  Text("Action,Thriller,Drama" , 
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(height: 10.h,),
                  Text("Peter Parker is dissatisfied with life when he loses his job, the love of his life and his powers. Amid all the chaos, he must fight Doctor Octavius, who threatens to destroy New York City.", 
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF706E6E),)
                  
                  ),
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                      return  Container(
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 5.w),                  
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "+19",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                    },  
                                   ),
                  )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
