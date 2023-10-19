class ApiConstance{
  static const apiKey='cu6vJkQ1xqfuuJCW/eBxGA==KrEoAAAyCphFxtsr';
  static const String baseUrl = 'https://api.api-ninjas.com/v1';
  static String quotesPath(String category){
    return '$baseUrl/quotes?category=$category';
  }
}