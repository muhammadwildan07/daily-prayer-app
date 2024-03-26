part of 'doas.dart';

Future<List<Doa>> fetchDoa() async {
  final response = await http
      .get(Uri.parse('https://doa-doa-api-ahmadramadhan.fly.dev/api'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Doa.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load data from API');
  }
}