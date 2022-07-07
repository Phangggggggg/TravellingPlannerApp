class CovidModel {
  String? txnDate;
  int? newCase;
  int? totalCase;
  int? newCaseExAbroad;
  int? totalCaseExAbroad;
  int? newDeath;
  int? totalDeath;
  int? newRecvoered;
  int? totalRecoverd;
  String? updateDate;

  CovidModel(
      {this.txnDate,
      this.newCase,
      this.totalCase,
      this.newCaseExAbroad,
      this.totalCaseExAbroad,
      this.newDeath,
      this.totalDeath,
      this.newRecvoered,
      this.totalRecoverd,
      this.updateDate});

  static CovidModel fromJson(json) {
    CovidModel covidModel = new CovidModel(
        txnDate: json['txn_date'],
        newCase: json['new_case'],
        totalCase: json['total_case'],
        newCaseExAbroad: json['new_case_excludeabroad'],
        totalCaseExAbroad: json['total_case_excludeabroad'],
        newDeath: json['new_death'],
        totalDeath: json['total_death'],
        newRecvoered: json['new_recovered'],
        totalRecoverd: json['total_recovered'],
        updateDate: json['update_date']);
    return covidModel;
  }
}
