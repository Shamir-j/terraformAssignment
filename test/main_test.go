package main

import (
	"fmt"
	"log"
	"testing"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformResourceGroup(t *testing.T) {

	expectedName := fmt.Sprintf("Flugel%s", random.UniqueId())
	expectedOwner := fmt.Sprintf("InfraTeam%s", random.UniqueId())

	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

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

	
	t.Log(apply)
	// var jsonEC2Tags map[string]interface{}
	// assert.Equal(t, map[string]interface{}{"Name": expectedName, "Owner": expectedOwner}, jsonEC2Tags)
	instanceID := terraform.Output(t, terratestOptions, "instance_name")
	
	aws.AddTagsToResource(t, awsRegion, instanceID, map[string]string{"testing": "testing-tag-value"})

	instanceTags := aws.GetTagsForEc2Instance(t, awsRegion, instanceID)

	testingTag, containsTestingTag := instanceTags["testing"]
	assert.True(t, containsTestingTag)
	assert.Equal(t, "testing-tag-value", testingTag)

	// Verify that our expected name tag is one of the tags
	nameTag, containsNameTag := instanceTags["Name"]
	assert.True(t, containsNameTag)
	assert.Equal(t, expectedName, nameTag)

	
	// log.Println(instanceID)
	// instanceName := aws.GetRandomRegion(t, instanceID, awsRegion)
	// instanceOwner := aws.GetRandomRegion(t, instanceID, awsRegion)
	// assert.Equal(t, expectedName, instanceName)
}
