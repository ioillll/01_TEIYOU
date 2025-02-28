/**
 * 
 * {
 * "publishingOffice":"気象庁",
 * "reportDatetime":"2025-01-22T16:34:00+09:00",
 * "targetArea":"東京都",
 * "headlineText":"",
 * "text":"　関東甲信地方は高気圧に緩やかに覆われています。一方、関東地方から伊豆諸島にかけて気圧の谷となっています。\n\n　東京地方は、おおむね晴れています。\n\n　２２日は、高気圧に覆われますが、気圧の谷や湿った空気の影響を受ける見込みです。このため、晴れ夜遅く曇りとなるでしょう。\n\n　２３日は、引き続き高気圧に覆われますが、気圧の谷や湿った空気の影響を受ける見込みです。このため、晴れ時々曇りとなるでしょう。\n\n【関東甲信地方】\n　関東甲信地方は、晴れや曇りとなっています。\n\n　２２日は、高気圧に覆われますが、気圧の谷や湿った空気の影響を受ける見込みです。このため、晴れや曇りとなるでしょう。\n\n　２３日は、引き続き高気圧に覆われますが、気圧の谷や湿った空気の影響を受ける見込みです。このため、晴れや曇りで、伊豆諸島では雨の降る所があるでしょう。\n\n　関東地方と伊豆諸島の海上では、２２日から２３日にかけて、うねりを伴い波が高い見込みです。船舶は高波に注意してください。"
 * }
 * 
 */


class WeatherResponse {

  // パラメータ定義
  final String publishingOffice;
  final String reportDatetime;
  final String targetArea;
  final String headlineText;
  final String text;

  // コンストラクタ
  WeatherResponse({
    required this.publishingOffice,
    required this.reportDatetime,
    required this.targetArea,
    required this.headlineText,
    required this.text,
  });


  // jsonデータをWeatherResponseクラスに変換
  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      publishingOffice: json['publishingOffice'],
      reportDatetime: json['reportDatetime'],
      targetArea: json['targetArea'],
      headlineText: json['headlineText'],
      text: json['text'],
    );
  }

}

