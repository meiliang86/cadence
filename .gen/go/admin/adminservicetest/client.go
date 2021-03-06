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

// Code generated by thriftrw-plugin-yarpc
// @generated

package adminservicetest

import (
	"context"
	"github.com/golang/mock/gomock"
	"github.com/uber/cadence/.gen/go/admin"
	"github.com/uber/cadence/.gen/go/admin/adminserviceclient"
	"github.com/uber/cadence/.gen/go/shared"
	"go.uber.org/yarpc"
)

// MockClient implements a gomock-compatible mock client for service
// AdminService.
type MockClient struct {
	ctrl     *gomock.Controller
	recorder *_MockClientRecorder
}

var _ adminserviceclient.Interface = (*MockClient)(nil)

type _MockClientRecorder struct {
	mock *MockClient
}

// Build a new mock client for service AdminService.
//
// 	mockCtrl := gomock.NewController(t)
// 	client := adminservicetest.NewMockClient(mockCtrl)
//
// Use EXPECT() to set expectations on the mock.
func NewMockClient(ctrl *gomock.Controller) *MockClient {
	mock := &MockClient{ctrl: ctrl}
	mock.recorder = &_MockClientRecorder{mock}
	return mock
}

// EXPECT returns an object that allows you to define an expectation on the
// AdminService mock client.
func (m *MockClient) EXPECT() *_MockClientRecorder {
	return m.recorder
}

// InquiryWorkflowExecution responds to a InquiryWorkflowExecution call based on the mock expectations. This
// call will fail if the mock does not expect this call. Use EXPECT to expect
// a call to this function.
//
// 	client.EXPECT().InquiryWorkflowExecution(gomock.Any(), ...).Return(...)
// 	... := client.InquiryWorkflowExecution(...)
func (m *MockClient) InquiryWorkflowExecution(
	ctx context.Context,
	_InquiryRequest *shared.DescribeWorkflowExecutionRequest,
	opts ...yarpc.CallOption,
) (success *admin.InquiryWorkflowExecutionResponse, err error) {

	args := []interface{}{ctx, _InquiryRequest}
	for _, o := range opts {
		args = append(args, o)
	}
	i := 0
	ret := m.ctrl.Call(m, "InquiryWorkflowExecution", args...)
	success, _ = ret[i].(*admin.InquiryWorkflowExecutionResponse)
	i++
	err, _ = ret[i].(error)
	return
}

func (mr *_MockClientRecorder) InquiryWorkflowExecution(
	ctx interface{},
	_InquiryRequest interface{},
	opts ...interface{},
) *gomock.Call {
	args := append([]interface{}{ctx, _InquiryRequest}, opts...)
	return mr.mock.ctrl.RecordCall(mr.mock, "InquiryWorkflowExecution", args...)
}
