class FirestoreConstants{

  //Firebase Firestore collection keys
  static String pathUsersCollection = 'Users';
  static String email = 'email';
  static String name = 'name';
  static String fcmToken = 'fcmToken';
  static String isVendor = 'isVendor';
  static String isCustomer = 'isCustomer';
  static String userId = 'userId';


  //chat keys
  static String pathMessageCollection = 'Chat';
  static String message = 'message';
  static String senderId = 'senderId';
  static String senderName = 'senderName';
  static String receiverId = 'receiverId';
  static String receiverName = 'receiverName';
  static String timestamp = 'timestamp';
  static String type = 'type';
  static String isSeen = 'isSeen';


  //recentChat keys
  static String pathRecentChatCollection = 'RecentChat';
  static String recentUserId = 'recentUserId';
  static String recentUserName = 'recentUserName';
  static String recentMessage = 'recentMessage';
  static String recentTimeStamp = 'recentTimeStamp';



}