# spinsnitch_api.model.PutUpdatePushTokenPayload

## Load the model package
```dart
import 'package:spinsnitch_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**newToken** | **String** | New push token for given provider. | 
**oldToken** | **String** | Old token that can be deleted if present. | [optional] 
**provider** | **String** | Identifier of the provider the token is for (eg. \"fcm\", \"apn\"). Currently only \"fcm\" is supported. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


