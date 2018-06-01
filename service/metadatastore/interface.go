package metadatastore

import "github.com/uber/cadence/.gen/go/shared"

type MetadataStore interface {
	RegisterWorkflowDefinition(workflowDefinition *WorkflowDefinition)
	ListWorkflowDestination(domainID string) []*WorkflowDefinition
	ListWorkflowDestinationByName(domainID, name string) []*WorkflowDefinition
	StartWorkflowExecution(id string, input []*MaterializedParam) (shared.WorkflowExecution, error)

	RegisterResources(domainID string, resources []*Resource)
	GetResource(id string, version string) (Resource, error)
	GetResourceByName(domainID string, name string, version string, parentID string) (Resource, error)
}

type WorkflowDefinition struct {
	Name     string
	ID       string
	ParentID string
	Version  string
	Input    []*Param
	Output   []*Param
	DomainID string
}

type Param struct {
	Type string // Builtin go types/workflow/activity/resource
	Name string
}

type MaterializedParam struct {
	Param
	Value interface{}
}

type Resource struct {
	Name       string
	Type       string
	ID         string
	ParentID   string
	Version    string
	Content    []byte
	Executable bool
}
