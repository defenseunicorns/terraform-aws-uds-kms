.PHONY: help
help: ## Show a list of all targets
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1:\3/p' \
	| column -t -s ":"

.PHONY: tfdocs
tfdocs: ## update the terraform docs
	tofu init
	tofu validate
	tofu fmt -recursive
	terraform-docs markdown table --indent 2 --output-mode inject --output-file README.md .

.PHONY: tflint
tflint: ## tflint
	tflint
	
lint-go: ## Run golang-ci-lint to lint the go code (must `brew install golangci-lint` first)
	golangci-lint run
