class ApiService {
  static String urlApi = "http://192.168.1.77:7240";

  static void updateApiUrl(String? newUrl) {
    urlApi = newUrl ?? "http://192.168.1.77:7240";
  }
}