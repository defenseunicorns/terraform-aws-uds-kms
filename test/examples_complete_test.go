package test_test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

const testDir = "../examples/complete"
const kmsKeyAliasOutput = "kms_key_alias"
const kmsKeyAliasVar = "kms_key_alias_name_prefix"
const kmsKeyAliasPrefix = "alias/terratest"
const regionVar = "region"

func TestExampleComplete(t *testing.T) {
	t.Parallel()

	var approvedRegions = []string{"us-east-1", "us-east-2", "us-west-1", "us-west-2"}
	awsRegion := aws.GetRandomStableRegion(t, approvedRegions, nil)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: testDir,

		Vars: map[string]interface{}{
			kmsKeyAliasVar: kmsKeyAliasPrefix,
			regionVar:      awsRegion,
		},

		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	actualKeyAlias := terraform.Output(t, terraformOptions, kmsKeyAliasOutput)

	assert.Contains(t, actualKeyAlias, kmsKeyAliasPrefix)
}
