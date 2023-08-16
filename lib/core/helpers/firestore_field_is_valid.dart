bool isFirestoreFieldValid(Map<String, dynamic>? data, String fieldKey) {
  if (data == null) {
    return false;
  }

  return data.containsKey(fieldKey) &&
      data[fieldKey] != null &&
      data[fieldKey].isNotEmpty;
}
