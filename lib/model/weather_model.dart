class WeatherResponse {
  final String publishingOffice;
  final String reportDatetime;
  final String targetArea;
  final String headlineText;
  final String text;

  WeatherResponse({
    required this.publishingOffice,
    required this.reportDatetime,
    required this.targetArea,
    required this.headlineText,
    required this.text,
  });

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