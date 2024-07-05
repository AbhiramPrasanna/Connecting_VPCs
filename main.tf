provider "google" {
  project = var.project_id
  region  = var.region1
}

variable "project_id" {
  description = "The ID of the GCP project"
}

variable "region1" {
  description = "The first region for the VPC"
  default     = "us-central1"
}

variable "region2" {
  description = "The second region for the VPC"
  default     = "europe-west1"
}

variable "shared_secret" {
  description = "The shared secret for the VPN tunnel"
  default     = "your-shared-secret"
}

# Create VPC and Subnet in Region 1
resource "google_compute_network" "vpc1" {
  name                    = "vpc1"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet1"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.vpc1.name
  region        = var.region1
}

# Create VPC and Subnet in Region 2
resource "google_compute_network" "vpc2" {
  name                    = "vpc2"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "subnet2"
  ip_cidr_range = "10.1.0.0/16"
  network       = google_compute_network.vpc2.name
  region        = var.region2
}

# Create VPN Gateway in Region 1
resource "google_compute_vpn_gateway" "vpn_gateway1" {
  name    = "vpn-gateway1"
  network = google_compute_network.vpc1.name
  region  = var.region1
}

# Create VPN Gateway in Region 2
resource "google_compute_vpn_gateway" "vpn_gateway2" {
  name    = "vpn-gateway2"
  network = google_compute_network.vpc2.name
  region  = var.region2
}

# Create VPN Tunnel from VPC1 to VPC2
resource "google_compute_vpn_tunnel" "tunnel1" {
  name              = "tunnel1"
  region            = var.region1
  target_vpn_gateway = google_compute_vpn_gateway.vpn_gateway1.self_link
  peer_ip           = google_compute_vpn_gateway.vpn_gateway2.ip_address
  shared_secret     = var.shared_secret
  ike_version       = 2
}

# Create VPN Tunnel from VPC2 to VPC1
resource "google_compute_vpn_tunnel" "tunnel2" {
  name              = "tunnel2"
  region            = var.region2
  target_vpn_gateway = google_compute_vpn_gateway.vpn_gateway2.self_link
  peer_ip           = google_compute_vpn_gateway.vpn_gateway1.ip_address
  shared_secret     = var.shared_secret
  ike_version       = 2
}

# Create Route from VPC1 to VPC2
resource "google_compute_route" "route_to_vpc2" {
  name            = "route-to-vpc2"
  network         = google_compute_network.vpc1.self_link
  dest_range      = "10.1.0.0/16"
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1.self_link
}

# Create Route from VPC2 to VPC1
resource "google_compute_route" "route_to_vpc1" {
  name            = "route-to-vpc1"
  network         = google_compute_network.vpc2.self_link
  dest_range      = "10.0.0.0/16"
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel2.self_link
}
