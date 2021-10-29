package main

import (
	"fmt"
	"log"
	"testing"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformResourceGroup(t *testing.T) {

	expectedName := fmt.Sprintf("Flugel%s", random.UniqueId())
	expectedOwner := fmt.Sprintf("InfraTeam%s", random.UniqueId())

	terratestOptions := &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"tag_name":  expectedName,
			"tag_owner": expectedOwner,
		},
	}

	defer terraform.Destroy(t, terratestOptions)

	init, err := terraform.InitE(t, terratestOptions)
	if err != nil {
		log.Println(err)
	}
	t.Log(init)

	plan, err := terraform.PlanE(t, terratestOptions)
	if err != nil {
		log.Println(err)
	}
	t.Log(plan)
	apply, err := terraform.ApplyE(t, terratestOptions)
	if err != nil {
		log.Println(err)
	}
	var jsonEC2Tags map[string]interface{}
	t.Log(apply)
	assert.Equal(t, map[string]interface{}{"Name": expectedName, "Owner": expectedOwner}, jsonEC2Tags)

}
