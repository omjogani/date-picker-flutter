class Validators {
  String? validateDate(String date) {
    int days = -1, month = -1, year = -1;
    bool daysStatus = false, monthStatus = false, yearStatus = false;
    if (date.length > 2) {
      daysStatus = true;
      days = int.parse("${date[0]}${date[1]}");
    }
    if (date.length > 5) {
      monthStatus = true;
      month = int.parse("${date[3]}${date[4]}");
    }
    if (date.length >= 10) {
      yearStatus = true;
      year = int.parse("${date[6]}${date[7]}${date[8]}${date[9]}");
    }
    if (date.isEmpty) {
      return "Date is Required!";
    } else if (date.length > 10) {
      return "Invalid Date!";
    } else if (days < 1 || days > 31) {
      if (daysStatus) {
        return "Invalid Day!";
      }
    } else if (month < 1 || month > 12) {
      if (monthStatus) {
        return "Invalid Month!";
      }
    } else if (year < 1954 || year > DateTime.now().year) {
      if (yearStatus) {
        return "Invalid Year!";
      }
    }
    return null;
  }
}
