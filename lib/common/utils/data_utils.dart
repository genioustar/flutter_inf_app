class DataUtils {
  // 이미지 경로를 URL로 변환하는 메서드
  static String pathToUrl(String path) {
    return 'https://picsum.photos/id$path/200/300';
  }

  // 서버에서 받을때는 dynamic 타입이라서 이를 List<String>으로 변환하는 메서드
  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}
