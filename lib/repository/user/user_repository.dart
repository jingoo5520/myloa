import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_template/model/character/character_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_repository.g.dart';

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET('/characters/{characterName}/siblings')
  @Headers({
    'authorization':
        'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IktYMk40TkRDSTJ5NTA5NWpjTWk5TllqY2lyZyIsImtpZCI6IktYMk40TkRDSTJ5NTA5NWpjTWk5TllqY2lyZyJ9.eyJpc3MiOiJodHRwczovL2x1ZHkuZ2FtZS5vbnN0b3ZlLmNvbSIsImF1ZCI6Imh0dHBzOi8vbHVkeS5nYW1lLm9uc3RvdmUuY29tL3Jlc291cmNlcyIsImNsaWVudF9pZCI6IjEwMDAwMDAwMDAxNjYyNTUifQ.lKDDempzeWB5YZOKZzLkPM-ZOaTBv9uCl9ZLcCIoMdddPUvFBGAoKN282WqTsc9ddK-YmaTI9LcFZj79lsajcrrRkWsrsA0Hh7JVl0nVbvd2aGJks8ci4kIbhw2JG0rqOXt6rm_rwP_Phb0WhsWqLUzF4YAMp4U5-69YXxMjlwhkegjYnSdMR1zr3VpNANivfZi3UEIpeOUiMbPI_qp7oJkrHuUTJm09xLc05P8iM1YcDMzO5vHimcZ_hHNaAGH5tfvdy9I4TEbuO4D18i1Q_nhun_eVTK4MSnaj0Q2I1f0GAr1rKptsxym-gTLLkYQHKO5besIQb7Cdo6c6-MrZKA'
  })
  Future<List<CharacterModel>> getCharacter({
    @Path() required String characterName,
  });
}
