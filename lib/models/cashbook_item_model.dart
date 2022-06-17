// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cashbook/models/id.dart';
import 'package:cashbook/models/cashbook_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CashbookItemModel {
  final String id;
  final double amount;
  final bool taking;
  //final String bookingText;
  final double taxRate;
  final String documentNumber;
  final List<String> bookingTexts;
  final DateTime bookingDate;
  final DateTime created = DateTime.now().toUtc();
  final String yearMonth;
  final dynamic serverTimeStamp;

  CashbookItemModel(
      {required this.id,
      required this.amount,
      required this.taking,
      //required this.bookingText,
      required this.taxRate,
      required this.documentNumber,
      required this.bookingTexts,
      required this.bookingDate,
      required this.yearMonth,
      required this.serverTimeStamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'taking': taking,
      //'bookingText': bookingText,
      'taxRate': taxRate,
      'documentNumber': documentNumber,
      'bookingTexts': bookingTexts,
      'bookingDate': bookingDate.millisecondsSinceEpoch,
      'yearMonth': yearMonth,
      'serverTimeStamp': serverTimeStamp,
    };
  }

  factory CashbookItemModel.fromMap(Map<String, dynamic> map) {
    return CashbookItemModel(
      id: "",
      amount: (map['amount'] as num).toDouble(),
      taking: map['taking'] as bool,
      //bookingText: map['bookingText'] as String,
      taxRate: (map['taxRate'] as num).toDouble(),
      documentNumber: map['documentNumber'] as String,
      bookingTexts: (map['bookingTexts'] as List).map((item) => item as String).toList(),
      bookingDate: (map['bookingDate'] as Timestamp).toDate(),
      yearMonth: map['yearMonth'] as String,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }

  CashbookItemModel copyWith({
    String? id,
    double? amount,
    bool? taking,
    String? bookingText,
    double? taxRate,
    String? documentNumber,
    List<String>? bookingTexts,
    DateTime? bookingDate,
    String? yearMonth,
    dynamic? serverTimeStamp,
  }) {
    return CashbookItemModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      taking: taking ?? this.taking,
      //bookingText: bookingText ?? this.bookingText,
      taxRate: taxRate ?? this.taxRate,
      documentNumber: documentNumber ?? this.documentNumber,
      bookingTexts: bookingTexts ?? this.bookingTexts,
      bookingDate: bookingDate ?? this.bookingDate,
      yearMonth: yearMonth ?? this.yearMonth,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  factory CashbookItemModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return CashbookItemModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  CashbookItem toDomain() {
    return CashbookItem(
        id: UniqueID.fromUniqueString(id),
        amount: amount,
        taking: taking,
        //bookingText: bookingText,
        taxRate: taxRate,
        documentNumber: documentNumber,
        bookingTexts: bookingTexts,
        created: created,
        yearMonth: yearMonth);
  }

  factory CashbookItemModel.fromDomain(CashbookItem cashbookItem) {
    return CashbookItemModel(
        id: cashbookItem.id.value,
        amount: cashbookItem.amount,
        taking: cashbookItem.taking,
        //bookingText: cashbookItem.bookingText,
        taxRate: cashbookItem.taxRate,
        documentNumber: cashbookItem.documentNumber,
        bookingTexts: cashbookItem.bookingTexts,
        bookingDate: cashbookItem.bookingDate,
        yearMonth: cashbookItem.yearMonth,
        serverTimeStamp: FieldValue.serverTimestamp());
  }
}
