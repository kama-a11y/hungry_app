import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungryapp/shared/custom_text.dart';

class ToppingItem extends StatefulWidget {
  const ToppingItem({super.key, required this.image, required this.title, this.ontap, this.isclicked = false });
  final String image;
  final String title;
  final Function()? ontap;
  final bool isclicked ;

  @override
  State<ToppingItem> createState() => _ToppingItemState();
}

class _ToppingItemState extends State<ToppingItem> {
   
  @override
  Widget build(BuildContext context) {
    return Container(
              width: 120,
              height: 140,
              decoration: BoxDecoration(
                color: Color(0xff3C2F2F),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 95,
                    child: Image.network(widget.image,scale: 3,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                    
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 8),
                    child: Row(
                      children: [
                        CustomText(text: widget.title, size: 14,weight: FontWeight.bold,color: Colors.white,),
                        Spacer(),
                        GestureDetector(
                          onTap:widget.ontap,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor:widget.isclicked ? Colors.green : Color(0xffEF2A39),
                            child: Center(child: Icon(widget.isclicked ? CupertinoIcons.check_mark : CupertinoIcons.add,color: Colors.white,size: 15,)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
  }
}