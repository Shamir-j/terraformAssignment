package main

import (
	"log"
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	// "github.com/stretchr/testify/assert"
)

func TestTerraformresourceGroup(t *testing.T) {
	
	terratestOptions := &terraform.Options{
		TerraformDir: "./",
		Vars: map[string]interface{}{},
	}

	defer terraform.Destroy(t, terratestOptions )

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
 }

