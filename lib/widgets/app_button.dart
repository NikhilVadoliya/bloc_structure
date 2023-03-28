import 'package:flutter/material.dart';

//TODO: Change custom button design as per your requirements
class AppButton extends StatelessWidget {
  final Color? backgroundColor;
  final String text;
  final EdgeInsets? padding;
  final VoidCallback onTap;

  const AppButton(
      {Key? key, this.backgroundColor, required this.text, this.padding, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: padding ?? const EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(backgroundColor ?? Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
              ),
              onPressed: () => onTap.call(),
              child: Text(
                text,
                style: TextStyle(color: Theme.of(context).canvasColor),
              ),
            ),
          )),
    );
  }
}
