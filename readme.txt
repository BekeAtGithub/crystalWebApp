crystalWebApp/
│
├── crystalApp/ 
│   ├── src/
│   │   └── main.cr            # The main Crystal application file
│   └── shard.yml              # Crystal dependencies file (like a Gemfile in Ruby)
│
├── docker/
│   ├── Dockerfile             # Dockerfile to containerize the Crystal app
│   └── entrypoint.sh          # Optional entrypoint script to run inside Docker
│
├── terraform/
│   ├── main.tf                # Main Terraform configuration for ECS deployment
│   ├── variables.tf           # Input variables for Terraform
│   ├── outputs.tf             # Output values for Terraform
│   ├── provider.tf            # Terraform provider configurations (AWS)
│   └── ecs-task-definition.tf # ECS task definition for running the app
│
├── .github/
│   └── workflows/
│       └── ci-cd.yml          # GitHub Actions for CI/CD pipeline
│
├── .gitignore                 # Git ignore file
├── README.md                  # Project documentation
└── docker-compose.yml         # Docker Compose file for local testing

# crystal app
uses HTTP::Server module to setup a web server. 
retrieves the systems hostname using socket.gethostname, the node number can be assigned through environment variables 
listens on port 8080

the shard.yml expresses the app name, version, author, dependencies, and modules

# docker
shows base image, work directory, copies necessary files and installs dependencies
compiles and releases the app with crystal build src/main.cr --release 
exposes port 8080, and sets the node_number variable and runs auxillary commands

docker entrypoint runs the main application based on node number and port

# terraform 
main.tf has the provider, ecs cluster, task definition, ecs service, ecr repo
variable.tf has the key:pair assignments for region, subnets, security group ids
outputs.tf use the service name, cluster name and repo name to help track resources and referenced by terraform modules
provider.tf expands on the provider
ecs-task-definition.tf defines the ecs task, family, container definitions, compatibility and resource utilization for the crystal application
terraform.tfvars defines security group id, subnet and vpc names

# github action workflows
triggers pipelines with push and pull request events on the main branch
it builds jobs by pulling lastest code from the repo, setting up docker buildx for docker image builds, logging into AWS using aws credentials, pushes docker images to ECR and deploys via terraform

# miscellaneous files
.gitignore setup to ignore object files that are generated during compilations including shard dependencies and other log, terraform, dockerr-related and IDE specific files

docker-compose.yml specifies docker compose format version, and with services we can manage and test/simulate the crystal app, build, ports and environment 
