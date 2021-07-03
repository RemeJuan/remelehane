---
stackbit_url_path: posts/unit-testing-your-http-multipartrequest-network-method
title: Unit Testing your http.MultipartRequest network method
date: '2020-08-10T07:16:01.000Z'
excerpt: >-
  Recently I had to implement image uploading which required form data that
  cannot be done with the s...
tags:
  - fileupload
  - unittesting
  - flutterdevelopment
  - flutter
template: post
---


![](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*IHvlDw_HqNSpLJfsKbOr0Q.jpeg)

Recently I had to implement image uploading which required form data that cannot be done with the standard http.Clientand instead needs http.MultipartRequest.

We have been doing a big push to implement a proper TDD approach in our products over at Wyzetalk, so one of the first steps was to get this new method tested, however, it was not as easy as it was with testing http.Client.

Unlike with http.Client one needs to provide an instance that includes the 2 required arguments, type, and Uri. With our product being a white label and the file upload being used from multiple widgets I needed to cater for the possibility of different Uri’s. Then also for testing, in order to mock the method, I would need to pass it into the class or function.

Here is a simplified version of my resulting implementation.


```dart
Future<String> fileUpload({
  @required http.MultipartRequest multipartRequest,
  @required http.MultipartFile fileData,
  @required Map<String, String> payload,
}) async {
  final request = await multipartRequest
    ..headers.addAll({
      ...deviceInfoHeaders,
      "Authorization": 'Bearer FAKE\_TOKEN',
    })
    ..fields.addAll(payload)
    ..files.add(fileData);

  final response = await request.send();
  final respStr = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    return respStr;
  } else {
    throw ServerException();
  }
}
```


I am passing in both the multiPartRequestas well as the fileData so that the implementation point can prepare the data based on the type, image vs doc.

The payloadData is just any extra info that gets provided by the uploading widget.

Mocking http.Client is very simple as you can see by the below snippet.


```dart
class MockClient extends Mock implements http.Client {}
```


In order to get http.MultipartRequest there are a few extra things you may need to provide based on your specific use case.


```dart
class MockMultipartRequest extends Mock implements http.MultipartRequest {
  @override
  final Map<String, String> headers = {};

  @override
  final fields = <String, String>{};

  @override
  final files = <MultipartFile>[];
}
```


In my case, as you can see in the functions code sample, I am providing headers, fields in the case of the payload, and files.

For that, within the mock class, I have also added the overrides for the 3 fields to ensure the logical default persists within the tests.


```dart
void main() {
  NetworkFileManager networkFileManager;
  MockDeviceInformationHelper mockDeviceInformationHelper;
  MockMultipartRequest mockMultipartRequest;

setUp(() {
  mockMultipartRequest = MockMultipartRequest();
  mockDeviceInformationHelper = MockDeviceInformationHelper();

networkFileManager = NetworkFileManager(
    deviceInformation: mockDeviceInformationHelper,
    headers: fixtureApiHeadersAuthed,
  );

when(mockDeviceInformationHelper.getDeviceInformation())
    .thenAnswer((\_) async => fixtureDeviceInfo);
  });

group('apiFileUpload', () {
    final mockPayload = Map<String, String>();
    final mockFile = http.MultipartFile.fromBytes(
      "file",
      [0],
      filename: 'file-name',
      contentType: http\_parser.MediaType(
        'image',
        'jpeg',
      ),
    );

test('should perform a File Upload request', () async {
      //arrange
      when(mockMultipartRequest.send()).thenAnswer(
        (\_) async => http.StreamedResponse(Stream.value([0]), 200),
      );
      //act
      await networkFileManager.fileUpload(
        payload: mockPayload,
        fileData: mockFile,
        multipartRequest: mockMultipartRequest,
      );
      //assert
      verify(mockMultipartRequest.send());
    });
  });
}
```


Here is a snippet from the test for the above function, I am passing in a mockFile and mocking the request's response, which returns an http.StreamedResponse which takes a Steam.value and the 200 response code.

This setup allows us to verify that when the function is called, the network request should get made by verifying that the mockMultipartRequest.send() is in fact called.

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

Wish to carry on with the topic of Unit Testing, take a look at:

- [Bringing localization into your Widget testing](https://remelehane.dev/posts/bringing-localization-into-your-widget-testing/)
- [Widget testing passed in function](https://remelehane.dev/posts/widget-testing-passed-in-function-/)
