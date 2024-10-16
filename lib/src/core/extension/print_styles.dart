extension PrintStyles on String {
  void printWarning() {
    print('\x1B[33m$this\x1B[0m'); // Yellow for warning
  }

  void printError() {
    print('\x1B[31m$this\x1B[0m'); // Red for error
  }

  void printNormal() {
    print(this); // Default print
  }
}
