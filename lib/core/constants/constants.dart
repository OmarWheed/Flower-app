const Map<String, Map<String, String>> egyptGovernorates = {
  "1": {"en": "Cairo", "ar": "القاهرة"},
  "2": {"en": "Giza", "ar": "الجيزة"},
  "3": {"en": "Alexandria", "ar": "الإسكندرية"},
  "4": {"en": "Dakahlia", "ar": "الدقهلية"},
  "5": {"en": "Red Sea", "ar": "البحر الأحمر"},
  "6": {"en": "Beheira", "ar": "البحيرة"},
  "7": {"en": "Fayoum", "ar": "الفيوم"},
  "8": {"en": "Gharbia", "ar": "الغربية"},
  "9": {"en": "Ismailia", "ar": "الإسماعيلية"},
  "10": {"en": "Menoufia", "ar": "المنوفية"},
  "11": {"en": "Minya", "ar": "المنيا"},
  "12": {"en": "Qalyubia", "ar": "القليوبية"},
  "13": {"en": "New Valley", "ar": "الوادي الجديد"},
  "14": {"en": "Suez", "ar": "السويس"},
  "15": {"en": "Aswan", "ar": "أسوان"},
  "16": {"en": "Assiut", "ar": "أسيوط"},
  "17": {"en": "Beni Suef", "ar": "بني سويف"},
  "18": {"en": "Port Said", "ar": "بور سعيد"},
  "19": {"en": "Damietta", "ar": "دمياط"},
  "20": {"en": "Sharkia", "ar": "الشرقية"},
  "21": {"en": "South Sinai", "ar": "جنوب سيناء"},
  "22": {"en": "Kafr El Sheikh", "ar": "كفر الشيخ"},
  "23": {"en": "Matrouh", "ar": "مطروح"},
  "24": {"en": "Luxor", "ar": "الأقصر"},
  "25": {"en": "Qena", "ar": "قنا"},
  "26": {"en": "North Sinai", "ar": "شمال سيناء"},
  "27": {"en": "Suhag", "ar": "سوهاج"},
};

class AppConstants {
  AppConstants._();

  static const String fcmAccessToken = 'fcm_access_token';

  static const String authorizationKey = "Authorization";
  static const String scopeUrl =
      "https://www.googleapis.com/auth/firebase.messaging";
}
