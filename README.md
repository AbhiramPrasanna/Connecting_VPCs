
# Creating VPCs in Different Regions and Connecting Them Using VPN Tunnel with Terraform

This repository provides a Terraform-based solution to create VPCs in different regions on Google Cloud and connect them using a VPN tunnel.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated.
- A Google Cloud project with billing enabled.

## Variables

Update the variables in `main.tf` as needed:
- `project_id`: Your Google Cloud project ID.
- `region1` and `region2`: The regions where you want to create VPCs.
- `shared_secret`: A shared secret for VPN authentication.

## Steps

### 1. Set up Google Cloud SDK

Ensure that you have the Google Cloud SDK installed and authenticated:

1. Install the Google Cloud SDK by following the instructions [here](https://cloud.google.com/sdk/docs/install).
2. Initialize the SDK and authenticate:

   ```sh
   gcloud init
   gcloud auth application-default login
   ```

### 2. Clone the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

### 3. Configure Terraform Variables

You can configure the Terraform variables directly in the `main.tf` file or by creating a `terraform.tfvars` file:

Create a `terraform.tfvars` file with the following content:

```hcl
project_id   = "your-project-id"
region1      = "us-central1"
region2      = "europe-west1"
shared_secret = "your-shared-secret"
```

Replace the placeholder values with your actual Google Cloud project ID and shared secret.

### 4. Initialize Terraform

Initialize Terraform in your project directory:

```sh
terraform init
```

### 5. Apply the Terraform Configuration

Apply the Terraform configuration to create the VPCs and VPN tunnel:

```sh
terraform apply
```

Enter the necessary variable values if prompted (e.g., project ID and shared secret).

### Additional Resources

- [Google Cloud VPC Documentation](https://cloud.google.com/vpc/docs)
- [Google Cloud VPN Documentation](https://cloud.google.com/vpn/docs)
- [Terraform GCP Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
```

