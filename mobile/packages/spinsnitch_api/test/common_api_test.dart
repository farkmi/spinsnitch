//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:spinsnitch_api/api.dart';
import 'package:test/test.dart';


/// tests for CommonApi
void main() {
  // final instance = CommonApi();

  group('tests for CommonApi', () {
    // Get healthy (liveness probe)
    //
    // This endpoint returns 200 when the service is healthy. Returns an human readable string about the current service status. In addition to readiness probes, it performs actual write probes. Note that /-/healthy is private (shielded by the mgmt-secret) as it may expose sensitive information about your service.
    //
    //Future getHealthyRoute() async
    test('test getHealthyRoute', () async {
      // TODO
    });

    // Get ready (readiness probe)
    //
    // This endpoint returns 200 when the service is ready to serve traffic. Does read-only probes apart from the general server ready state. Note that /-/ready is typically public (and not shielded by a mgmt-secret), we thus prevent information leakage here and only return `\"Ready.\"`.
    //
    //Future getReadyRoute() async
    test('test getReadyRoute', () async {
      // TODO
    });

    // Get swagger.yml
    //
    // OpenAPI Specification ver. 2 (fka Swagger) Returns our handcrafted and validated `swagger.yml`.
    //
    //Future getSwaggerRoute() async
    test('test getSwaggerRoute', () async {
      // TODO
    });

    // Get version
    //
    // This endpoint returns the module name, commit and build-date baked into the app binary.
    //
    //Future getVersionRoute() async
    test('test getVersionRoute', () async {
      // TODO
    });

  });
}
