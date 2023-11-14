class Status {
  bool? status;
  String? errNum;
  String? msg;

  Status({this.status, this.errNum, this.msg});

  Status.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errNum'] = errNum;
    data['msg'] = msg;
    return data;
  }
}
