# Software Engineer Assignment Interview

### Documentation

<ul style="list-style-type:circle">
<li>This repository is for a terraform assignment</li>
<li>The terraform script creates two resource EC2 instance and S3 bucket.</li>
<li>Terratest script ensure that the created resource we created as expected and tagged us required</li>
<li>Github actions added to the assignment to validate the code before deployemnt</li>
</ul>

### Running the setup

### Requirements

<ul style="list-style-type:circle">
<li>Terraform Cli</li>
<li>AWS account</li>
<li>Terraform cloud account</li>
</ul>

To run the setup ensure you have the listed requirements above. Then do the following.

### Run locally

<ul style="list-style-type:circle">
<li>Clone the code to your github account.</li>
<li>Create a pull request</li>
<li>Cd into the project folder in your machine</li>
<li>Run the command terraform init for terraform to download all the terraform plugins</li>
<li>Run the command terraform plan. The command will excute a plan for terraform listing the number of resources to be created and changes to be applied</li>
<li>Run the command terraform apply to apply the changes which will create the resources on the AWS account</li>
</ul>

If you have logged in into your cloud machine on AWS you can follow the above process.

GitHub action have been added to the script to automate tghe process of terraform init terraform plan and terraform apply which will excute after the push request has been approved which will create the resource on the cloud account.

### Running Terratest for the set up.

To run the terratest of the setup do the following.

<ul style="list-style-type:circle">
<li>Clone the code to your github account.</li>
<li>Create a pull request</li>
<li>Cd into the project folder in your machine and into the test folder</li>
<li>Run go mod download</li>
<li>Run go main.go command</li>
</ul>
