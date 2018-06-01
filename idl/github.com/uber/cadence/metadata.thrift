// Copyright (c) 2017 Uber Technologies, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

namespace java com.uber.cadence.metadata

include "shared.thrift"

enum Type {
  Integer,
  String,
  Duration,
  Binary,
  DSL,
  Task,
  Resource,
  TaskList,
  StartToCloseTimeout,
}

enum TaskType {
  Workflow,
  Activity,
}

struct TaskDefinition {
  10: optional TaskType type
  20: optional string name
  30: optional string version
  40: optional string id
  50: optional string parentId
  60: optional list<Param> inputs
  70: optional list<MaterializedParam> defaultInputs
  80: optional list<Param> outputs
  90: optional i64 (js.type = "Long") createdTime
  100: optional string createdBy
  110: optional string owner
}

struct Param {
  10: optional string name
  20: optional Type type
  30: optional i32 position
}

struct MaterializedParam {
  10: optional string name
  20: optional Type type
  30: optional i32 position
  40: optional binary value
}

struct RegisterTaskDefinitionRequest {
  10: optional string domainId
  20: optional TaskDefinition taskDefinition
}

struct ListTaskDefinitionRequest {
  10: optional string domainId
  20: optional string prefix
}

struct ListTaskDefinitionResponse {
  10: optional list<TaskDefinition> taskDefinitions
}

struct StartTaskExecutionRequest {
  10: optional string taskDefinitionId
  20: optional list<MaterializedParam> inputs
}

struct StartTaskExecutionResponse{
  10: optional shared.WorkflowExecution workflowExecution
}

struct Resource {
  10: optional string name
  20: optional string id
  30: optional Type type
  40: optional binary content
  50: optional i64 (js.type = "Long") createdTime
  60: optional string createdBy
}

struct RegisterResourceRequest {
  10: optional string domainId
  20: optional Resource resource
}

struct GetResourceRequest {
  10: optional string domainId
  20: optional string name
  30: optional string id
}

struct GetResourceResponse {
  10: optional Resource resource
}

enum Version {
  Active = -1,
  Latest = -2,
}

struct ResourceSet {
  10: optional string name
  20: optional i32 version
  30: optional list<string> resources
  40: optional string owner
  50: optional i64 (js.type = "Long") createdTime
  60: optional string createdBy
}

struct RegisterResourceSetRequest {
  10: optional string domainId
  20: optional ResourceSet resourceSet
}

struct ActivateResourceSetRequest {
  10: optional string domainId
  20: optional string name
  30: optional i32 version
}

struct ActivateResourceSetResponse {
  10: optional i32 prevVersion
}

struct RollbackResourceSetRequest {
  10: optional string domainId
  20: optional string name
}

struct RollbackResourceSetResponse {
  10: optional i32 prevVersion
  20: optional i32 currVersion
}

struct GetResourcesByResourceSetRequest {
  10: optional string domainId
  20: optional string name
  30: optional i32 version = Version.Latest
}

struct GetResourcesByResourceSetResponse {
  10: optional list<Resource> resources
}

struct ListResourceSetVersionsRequest {
  10: optional string domainId
  20: optional string name
}

struct ListResourceSetVersionsResponse {
  10: optional list<ResourceSet> resourceSets
}

struct ListResourceSetsRequest {
  10: optional string domainId
}

struct ListResourceSetsResponse {
  10: optional list<ResourceSet> resourceSets
}

service MetadataService {
  void RegisterTaskDefinition(1: RegisterTaskDefinitionRequest request)
  ListTaskDefinitionResponse ListTaskDefinition(1: ListTaskDefinitionResponse request)
  StartTaskExecutionResponse StartTaskExecution(1: StartTaskExecutionRequest request)

  void RegisterResource(1: RegisterResourceRequest request)
  GetResourceResponse GetResource(1: GetResourceRequest request)

  void RegisterResourceSet(1: RegisterResourceSetRequest request)
  ActivateResourceSetResponse ActivateResourceSet(1: ActivateResourceSetRequest request)
  RollbackResourceSetResponse RollbackResourceSet(1: RollbackResourceSetRequest request)
  GetResourcesByResourceSetResponse GetResourcesByResourceSet(1: GetResourcesByResourceSetRequest request)
  ListResourceSetVersionsResponse ListResourceSetVersions(1: ListResourceSetVersionsRequest request)
  ListResourceSetsResponse ListResourceSets(1: ListResourceSetsRequest request)
}