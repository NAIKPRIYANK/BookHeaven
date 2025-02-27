
import 'package:dio/dio.dart';




class ApiServices{
  final Dio _dio = Dio();
  
  // ignore: non_constant_identifier_names
  ApiService() {
    // _dio.options.baseUrl = 'https://your-base-url.com'; // Replace with your API base URL
    _dio.options.connectTimeout = const Duration(seconds: 10); // Connection timeout
    _dio.options.receiveTimeout = const Duration(seconds: 10); // Receive timeout
  }




  // Future<List<String>> searchIndustries(String searchTerm) async {
  //   try {
  //     final response = await _dio.get(
  //       ApiConstants.getSearchedIndustries(search: searchTerm),
  //       // queryParameters: {'q': searchTerm},
  //     );

  //     if (response.statusCode == 200) {
  //       // Extract the list of strings from the 'data' field
  //       List<String> industries = List<String>.from(response.data['data']);
  //       return industries;
  //     } else {
  //       throw Exception('Failed to load industries');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching industries: $e');
  //   }
  // }

  // Future<List<String>> searchSubIndustries(String industry, String subIndustry) async {
  //   try {
  //     final response = await _dio.post(
  //       ApiConstants.getSubIndustryByIndustry(search: subIndustry, industry: industry),
  //       // queryParameters: {'subIndustry': subIndustry},
  //     );
  //     // print("Recieved sub industries from Api CAll ${response.data}");
  //     if (response.statusCode == 201) {

  //       // Check if the response data is a List
  //       if (response.data is List) {
  //         // Convert the list items to strings
  //         List<String> subIndustries = List<String>.from(response.data.map((item) => item.toString()));
  //         return subIndustries;
  //       } else {
  //         throw Exception('Unexpected response format. Expected a list of strings.');
  //       }
  //     } else {
  //       throw Exception('Failed to load sub-industries');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching sub-industries: $e');
  //   }
  // }

  // // Handle Errors
  // void _handleError(DioException error) {
  //   if (kDebugMode) {
  //     print('Error: ${error.response?.statusCode} - ${error.response?.data}');
  //   }
  //   throw error;
  // }
  // Create Regular Job




}