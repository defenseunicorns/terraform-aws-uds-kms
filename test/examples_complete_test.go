package test_test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

const testDir = "../examples/complete"
const kmsKeyAliasOutput = "kms_key_alias"
const kmsKeyAliasVar = "kms_key_alias_name_prefix"
const kmsKeyAliasPrefix = "alias/terratest"

func TestExampleComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: testDir,

		Vars: map[string]interface{}{
			kmsKeyAliasVar: kmsKeyAliasPrefix,
		},

		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	actualKeyAlias := terraform.Output(t, terraformOptions, kmsKeyAliasOutput)

	assert.Contains(t, actualKeyAlias, kmsKeyAliasPrefix)
}
