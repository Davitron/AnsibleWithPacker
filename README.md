# AnsibleWithPacker

##  About
AnsibleWithPacker is a simple program that uses [`Packer`](https://www.packer.io/) for building my checkpoint image, [`Ansible`](https://www.ansible.com/) for provisioning and [`Terraform`](https://www.terraform.io/) for creating resources on Amazon web services.

### Instructions
The instructions below would walk you through on building an image and launch it with `terraform`:

1. Clone the repository and `cd` into `AnsibleWithPacker` directory

    ```
     git clone https://github.com/kensanni/AnsibleWithPacker.git
     
     cd AnsibleWithPacker
    ```
 2.  To build the image, run
      ```
      packer build packerTemplate.json
      ```
 3.   After the image has been built, we are going to create and run the instance with the built image(`AMI`). To do that `cd`       into the `terraform` directory and initialize terraform. Ensure you have terraform installed(run `terraform -v`) if not       run `brew install terraform` to install terraform with Homebrew.
      
      ```   
      cd terraform
      
      terraform init
      ```
  4.  In the terraform directory, create a new file with the name `terraform.tfvars`. This file would contain the aws `secret`       and `access` key. run `touch terraform.tfvars` command to create the file. Input your aws secret and access key into
      the file.
      ```
      access_key = "YOUR_AWS_ACCESS_KEY"

      secret_key = "YOUR_AWS_SECRET_KEY"
      ```
5.    Login into your AWS management console and create a key pair with name `admin-key-pair-candacentral`, this enables you       SSH into the created instance. Terraform would look for a key pair named `admin-key-pair-candacentral` when creating the       instance. You can do that by following the steps below
      >- On your AWS management console, click on the `Services` drop-down, under the `Compute` section click on EC2.
      >- On EC2 dashboard, By the side-navigation bar under `NETWORK & SECURITY` section, click on `Key Pairs`.
      >- Click on the button with `Create Key Pair` description and input `admin-key-pair-candacentral` as the key pair name            value.
6.    Now go back to your terminal and run `terraform apply` to create the resources. This would also create a defined               security group with `SSH` restricted to `41.215.245.118/32` and `169.239.188.10/32` IP address, `HTTP` accessible from         anywhere. You can also change the security group to suite your needs in `instance.tf` file under `terraform` directory.
7.    running `terraform apply` would console the public DNS as `Output = YOUR PUBLIC DNS` on your terminal on every                 successful run. copy the public DNS and paste it into your browser. you should see a landing page.
