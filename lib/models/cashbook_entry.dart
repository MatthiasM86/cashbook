class CashbookEntry {
  String userId;
  double amount;
  bool taking;
  String bookingText = '';
  double? taxRate = 0;
  String documentNumber = '';
  List<String> bookingTexts = [];
  DateTime bookingDate = DateTime.now().toUtc();
  DateTime created = DateTime.now().toUtc();
  String? yearMonth;
  CashbookEntry(this.userId, this.amount, this.taking) {
    if(bookingText.isNotEmpty){
      bookingTexts.add(bookingText);
    }
  }

  CashbookEntry.fromMap(Map<String, dynamic> data)
      : userId = data['userId'],
        amount = double.parse(data['amount']),
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
      'userId': userId, 
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
}
