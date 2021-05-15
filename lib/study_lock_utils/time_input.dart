// class TimeInput {
//   int _studyTime;
//   int _pauseTime;
//   int _cycle;

//   TimeInput(
//       {required int studyTime, required int pauseTime, required int cycle})
//       : _studyTime = studyTime,
//         _pauseTime = pauseTime,
//         _cycle = cycle;

//   TimeInput.fromMap(Map<String, dynamic> json)
//       : this._studyTime = json['studyTime'],
//         this._pauseTime = json['pauseTime'],
//         this._cycle = json['cycle'];

//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       'studyTime': _studyTime,
//       'pauseTime': _pauseTime,
//       'cycle': _cycle
//     };

//     return map;
//   }
// }
class TimeInput {
  int studyTime;
  int pauseTime;
  int cycle;

  TimeInput(
      {required this.studyTime, required this.pauseTime, required this.cycle});

  TimeInput.fromMap(Map<String, dynamic> json)
      : this.studyTime = json['studyTime'],
        this.pauseTime = json['pauseTime'],
        this.cycle = json['cycle'];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'studyTime': studyTime,
      'pauseTime': pauseTime,
      'cycle': cycle
    };

    return map;
  }
}
