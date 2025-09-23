class AppConstants {
  // Private constructor
  AppConstants._privateConstructor();

  // Singleton instance
  static final AppConstants _instance = AppConstants._privateConstructor();

  // Factory constructor
  factory AppConstants() {
    return _instance;
  }

  // Placeholder image URL
  static String placeHolderImage =
      'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=';
  static String placeHolderUserImg =
      'https://www.figma.com/file/WBrobYzVLC6bquXSRRoWOs/image/89fe31c79df8fb6bbfd99db1cb18960fb1e8e0e1';

  static var APP_NAME = "BuySell Direct";
  static var TOKEN = "";
  static var FCM_TOKEN = "1234";
}

enum TransactionType { credit, debit }
