import 'package:flutter/material.dart';
import 'package:hikicomic/utils/colors.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coin')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          columns: [
            DataColumn(
                label: Text('Pricing',
                    // textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall)),
            DataColumn(
                label: Text('Pricing',
                    // textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall)),
            DataColumn(
                label: Text('Benefit',
                    // textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall))
          ],
          // defaultVerticalAlignment: TableCellVerticalAlignment.middle,

          // columnWidths: {
          //   0: FlexColumnWidth(1),
          //   1: FlexColumnWidth(3),
          //   2: FlexColumnWidth(1),
          // },
          // defaultColumnWidth: ,
          border: TableBorder.all(
              color: kWhite, style: BorderStyle.solid, width: 0.2),
          rows: [],
          // children: [
          //   TableRow(children: [
          //     Column(
          //         // crossAxisAlignment: CrossAxisAlignment.center,
          //         // mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text('Pricing',
          //               // textAlign: TextAlign.center,
          //               style: Theme.of(context).textTheme.headlineSmall)
          //         ]),
          //     Column(children: [
          //       Text('Coin', style: Theme.of(context).textTheme.headlineSmall)
          //     ]),
          //     Column(children: [
          //       Text('Benefit',
          //           style: Theme.of(context).textTheme.headlineSmall)
          //     ]),
          //   ]),
          //   tableRow(),
          //   // TableRow(children: [
          //   //   Column(children: [
          //   //     Text('\$ 5'),
          //   //   ]),
          //   //   Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //   //     Icon(Icons.monetization_on),
          //   //     Text('20'),
          //   //     Spacer(),
          //   //     ElevatedButton(
          //   //       onPressed: () {},
          //   //       child: Text('Buy'),
          //   //       style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          //   //           backgroundColor: MaterialStatePropertyAll(kRed),
          //   //           shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          //   //               borderRadius: BorderRadius.circular(5)))),
          //   //     )
          //   //   ]),
          //   //   Column(children: [Text('5*')]),
          //   // ]),
          //   // TableRow(children: [
          //   //   Column(children: [Text('Javatpoint')]),
          //   //   Column(children: [Text('MySQL')]),
          //   //   Column(children: [Text('5*')]),
          //   // ]),
          //   // TableRow(children: [
          //   //   Column(children: [Text('Javatpoint')]),
          //   //   Column(children: [Text('ReactJS')]),
          //   //   Column(children: [Text('5*')]),
          //   // ]),
          // ],
        ),
      ),
    );
  }
}

TableRow tableRow(
    {required int pricing,
    required int coin,
    required String benefit,
    required BuildContext context}) {
  return TableRow(children: [
    Column(
      children: [
        Text('\$ $pricing'),
      ],
    ),
    Row(
      children: [
        Icon(Icons.monetization_on),
        Text(coin.toString()),
        Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: Text('Buy'),
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStatePropertyAll(kRed),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
        )
      ],
    ),
    Column(
      children: [Text(benefit)],
    )
  ]);
}
// class TableRowPayment extends StatelessWidget {
//   const TableRowPayment({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TableRow(
//       children: []
//     );
//   }
// }