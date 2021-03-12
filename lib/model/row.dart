class CustomAPIRow {
  final List elements;

  CustomAPIRow(this.elements);

  factory CustomAPIRow.fromData(Map<String, dynamic> data) {
    return CustomAPIRow(
      data['elements'],
    );
  }
}

