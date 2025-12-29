# spinsnitch_api.model.GetUserInfoResponse

## Load the model package
```dart
import 'package:spinsnitch_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**email** | **String** | Email address of user, if available | [optional] 
**scopes** | [**List<UserScope>**](UserScope.md) | Auth-Scopes of the user, if available | [optional] [default to const []]
**sub** | **String** | ID of user | 
**updatedAt** | **int** | Unix timestamp the user's info was last updated at | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


