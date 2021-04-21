class Status {
  final String statusText;
  final String statusColor;
  Status(this.statusColor, this.statusText);

  Status.fromJson(Map<String, dynamic> json)
      : statusText = json["text"],
        statusColor = json["color"];
}
