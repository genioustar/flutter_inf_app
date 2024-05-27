class DataUtils {
  // 이미지 경로를 URL로 변환하는 메서드
  static String pathToUrl(String path) {
    return 'https://picsum.photos/id$path/200/300';
  }

  static listPathsToUrls(List<String> paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}
