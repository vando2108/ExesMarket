
class DOB {
  final String day;
  final String month;
  final String year;
  
  DOB(
      {this.day,
      this.month,
      this.year,
     
    });

  factory DOB.fromJson(Map<String, dynamic> json) {
    return DOB(
      day: json['day'],
      year: json['year'],
      month: json['month'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}