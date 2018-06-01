package metadatastore

import (
	"testing"
	"fmt"
	"encoding/json"
	"github.com/pborman/uuid"
)

func TestMetadataSTore(t *testing.T) {
	def := WorkflowDefinition{
		Name:     "cron",
		ID:       uuid.New(),
		Input:    []*Param{{Name: "action", Type: "workflow"}, {Name: "schedule", Type: "duration"}},
		DomainID: "system",
	}

	bytes, _ := json.Marshal(def)

	fmt.Println(string(bytes))
}
