Map<String, dynamic> transforValuesToFields(Map<String, dynamic> payload) {
  Map<String, dynamic> result = {};
  for (String key in payload.keys) {
    switch (payload[key].runtimeType) {
      case String:
        result[key] = {'stringValue': payload[key]};
        break;
      case int:
        result[key] = {'integerValue': payload[key]};
        break;
      case double:
        result[key] = {'integerValue': payload[key]};
        break;
      case bool:
        result[key] = {'booleanValue': payload[key]};
        break;
      default:
        result[key] = {'stringValue': payload[key]};
        break;
    }
  }

  return {'fields': result};
}

Map<String, dynamic> transforFieldToValues(data) {
  final Map<String, dynamic> newObject = {};
  final Map<String, dynamic> fields = data['fields'];

  fields.forEach((String key, field) {
    final tempValue = field.values.toList()[0];
    newObject[key] = tempValue;
  });

  return newObject;
}
