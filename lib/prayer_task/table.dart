// part of'tasks.dart';
//
// import 'package:flutter/material.dart';
//
// DataTable dataTable(){
//   return DataTable(
//     columnSpacing: 20,
//     columns: const [
//       DataColumn(
//           label: Text(
//             ' ',
//             textAlign: TextAlign.center,
//           )),
//       DataColumn(
//           label: Text('Ada',
//               textAlign: TextAlign.center)),
//       DataColumn(
//           label: Text('Berjamaah',
//               textAlign: TextAlign.center)),
//       DataColumn(
//           label: Text('Masjid',
//               textAlign: TextAlign.center)),
//       DataColumn(
//           label: Text('Tadarus',
//               textAlign: TextAlign.center)),
//     ],
//     rows: [
//       DataRow(cells: [
//         const DataCell(Text('Shubuh')),
//         DataCell(buildCheckbox(0)),
//         DataCell(buildCheckbox(1)),
//         DataCell(buildCheckbox(2)),
//         DataCell(buildCheckbox(3)),
//       ]),
//       DataRow(cells: [
//         const DataCell(Text('Dzuhur')),
//         DataCell(buildCheckbox(4)),
//         DataCell(buildCheckbox(5)),
//         DataCell(buildCheckbox(6)),
//         DataCell(buildCheckbox(7)),
//       ]),
//       DataRow(cells: [
//         const DataCell(Text('Ashar')),
//         DataCell(buildCheckbox(8)),
//         DataCell(buildCheckbox(9)),
//         DataCell(
//           buildCheckbox(10),
//         ),
//         DataCell(buildCheckbox(11)),
//       ]),
//       DataRow(cells: [
//         const DataCell(Text('Maghrib')),
//         DataCell(buildCheckbox(12)),
//         DataCell(buildCheckbox(13)),
//         DataCell(
//           buildCheckbox(14),
//         ),
//         DataCell(buildCheckbox(15)),
//       ]),
//       DataRow(cells: [
//         const DataCell(Text('Isya')),
//         DataCell(buildCheckbox(16)),
//         DataCell(buildCheckbox(17)),
//         DataCell(
//           buildCheckbox(18),
//         ),
//         DataCell(buildCheckbox(19)),
//       ]),
//       // Tambahkan baris DataRow lainnya di sini sesuai kebutuhan
//     ],
//   ),
// }