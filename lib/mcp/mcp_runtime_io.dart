import 'mcp_isolate.dart';

Future<void> startMCPService() => MCPIsolate.start();

Future<void> stopMCPService() => MCPIsolate.stop();
