class CashbookMonth {
  String userId;
  String? yearMonth;
  double currentSumExpense = 0;
  double currentSumTaking = 0;
  DateTime created = DateTime.now().toUtc();

  CashbookMonth(this.userId);

  CashbookMonth.fromMap(Map<String, dynamic> data)
      : userId = data['userId'],
      currentSumExpense = data['currentSumExpense'] != null ? double.parse(data['currentSumExpense']) : 0,
      currentSumTaking = data['currentSumTaking'] != null ? double.parse(data['currentSumTaking']) : 0,
      created = data['created'] != null ? DateTime.parse(data['created']) : DateTime.now().toUtc(),
      yearMonth= data['yearMonth'];


  Map<String, dynamic> toMap() {
    return {
      'userId': userId, 
      'currentSumExpense': currentSumExpense, 
      'currentSumTaking': currentSumTaking, 
      'created': created, 
      'yearMonth': yearMonth
    };
  }
}
