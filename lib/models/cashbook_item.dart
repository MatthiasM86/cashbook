// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashbook/models/id.dart';

class CashbookItem {
  final UniqueID id;
  final double amount;
  final bool taking;
  String? bookingText;
  final double taxRate;
  final String documentNumber;
  final List<String> bookingTexts;
  DateTime bookingDate = DateTime.now().toUtc();
  final DateTime created;
  final String yearMonth;

  CashbookItem(
      {required this.id,
      required this.amount,
      required this.taking,
      //required this.bookingText,
      required this.taxRate,
      required this.documentNumber,
      required this.bookingTexts,
      required this.created,
      required this.yearMonth}) {
    if (bookingText != null) {
      if (bookingText!.isNotEmpty) {
        bookingTexts.add(bookingText!);
      }
    }
  }

  factory CashbookItem.empty() {
    return CashbookItem(
        id: UniqueID(),
        amount: 0,
        taking: false,
        //bookingText: "",
        taxRate: 0,
        documentNumber: "",
        bookingTexts: [],
        created: DateTime.now().toUtc(),
        yearMonth: "");
  }

  CashbookItem copyWith({
    UniqueID? id,
    double? amount,
    bool? taking,
    String? bookingText,
    double? taxRate,
    String? documentNumber,
    List<String>? bookingTexts,
    DateTime? created,
    DateTime? serverTimeStamp,
    String? yearMonth,
  }) {
    return CashbookItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      taking: taking ?? this.taking,
      //bookingText: bookingText ?? this.bookingText,
      taxRate: taxRate ?? this.taxRate,
      documentNumber: documentNumber ?? this.documentNumber,
      bookingTexts: bookingTexts ?? this.bookingTexts,
      created: created ?? this.created,
      yearMonth: yearMonth ?? this.yearMonth,
    );
  }

/*
  CashbookItem.fromMap(Map<String, dynamic> data)
       : amount = double.parse(data['amount']),
        taking = data['taking'],
        bookingText = data['bookingText'] ?? '',
        taxRate = data['taxRate'] != null ? double.parse(data['taxRate']) : 0,
        documentNumber = data['documentNumber'] ?? '',
        bookingTexts = data['bookingTexts'],
        created = data['created'] != null ? DateTime.parse(data['created']) : DateTime.now().toUtc(),
        bookingDate = data['bookingDate'] != null ? DateTime.parse(data['bookingDate']) : DateTime.now().toUtc(),
        yearMonth= data['yearMonth'];


  Map<String, dynamic> toMap() {
    return {
      'amount': amount, 
      'taking': taking, 
      'created': created,
      'bookingDate': bookingDate, 
      'taxRate': taxRate, 
      'documentNumber': documentNumber, 
      'bookingTexts': bookingTexts, 
      'yearMonth': yearMonth
    };
  }
  */

}
