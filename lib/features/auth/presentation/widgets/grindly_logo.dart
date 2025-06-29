import 'package:flutter/material.dart';

class GrindlyLogo extends StatelessWidget {
  const GrindlyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 11),
          alignment: Alignment.topCenter,
          height: MediaQuery.sizeOf(context).height * 0.062,
          width: MediaQuery.sizeOf(context).height * 0.035,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Text(
            'g',
            style: TextStyle(
              fontFamily: 'JacquesFrancois',
              fontSize: 27,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          'rindly',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'JacquesFrancois',
            fontSize: 36,
          ),
        ),
      ],
    );
  }
}
