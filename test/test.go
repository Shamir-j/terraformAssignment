// go get github.com/gruntwork-io/terratest
// go get github.com/stretchr/testify

// +build unit

package test

import (
   "github.com/gruntwork-io/terratest/modules/terraform"
   test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
   "github.com/stretchr/testify/assert"
   "path/filepath"
   "testing"
)

func TestTerraformresourceGroup(t *testing.T) {
   t.Parallel()
   _assignmentDir := test_structure.CopyTerraformFolderToTemp(t, "./", "test/assignment")
   exampleDir := filepath.Join(_assignmentDir, "static-site")
   terratestOptions := &terraform.Options{
      TerraformDir: exampleDir,
      Vars: map[string]interface{}{},
   }
   t.Logf("Running in %s", exampleDir)
   output := terraform.InitAndPlan(t, terratestOptions)
   assert.Contains(t, output, "2 to add, 0 to change, 0 to destroy", "Plan OK and should attempt to create 2 resources")

   defer terraform.Destrory(t, terratestOptions )

}