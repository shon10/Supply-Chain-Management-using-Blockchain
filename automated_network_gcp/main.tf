// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("able-balm-233517-aededab553e2.json")}"
 project     = "able-balm-233517"
 region      = "asia-east1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}


resource "google_compute_firewall" "private-blockchain" {
  name = "private-blockchain"
  network = "default"
  allow {
    protocol = "udp"
    ports = ["30300-30309"]
  }

  allow {
      protocol = "tcp"
      ports = ["8000-8010","30300-30309"]# Server RPC
    }

    source_tags = ["startup-node"]
    target_tags = ["startup-node"]
}



resource "google_compute_instance" "bootnode" {
 name         = "bootnode"
 machine_type = "n1-standard-1"
 zone         = "asia-east1-a"
 tags          = ["startup-node"]

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-1604-lts"
     size = 50
   }
 }



// Make sure flask is installed on all new instances for later steps
metadata = {
   foo = "bar"
       startup-script = "${file("${path.module}/bootnode.sh")}"
       
     }
    service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
}

 network_interface {
   network = "default"

   access_config {
     
     // Include this section to give the VM an external ip address
   }
 }
}
resource "google_compute_instance" "validnode1" {
 name         = "validnode1"
 machine_type = "n1-standard-1"
 zone         = "asia-east1-a"
 tags          = ["startup-node"]

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-1604-lts"
     size = 50
   }
 }



// Make sure flask is installed on all new instances for later steps
metadata = {
   foo = "bar"
       startup-script = "${file("${path.module}/requirements0.sh")}"
       
     }
    service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
}

 network_interface {
   network = "default"

   access_config {
     
     // Include this section to give the VM an external ip address
   }
 }
}
resource "google_compute_instance" "validnode2" {
 name         = "validnode2"
 machine_type = "n1-standard-1"
 zone         = "asia-east1-a"
 tags          = ["startup-node"]

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-1604-lts"
     size = 50
   }
 }



// Make sure flask is installed on all new instances for later steps
metadata = {
   foo = "bar"
       startup-script = "${file("${path.module}/requirements1.sh")}"
       
     }
    service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
}

 network_interface {
   network = "default"

   access_config {
     
     // Include this section to give the VM an external ip address
   }
 }
}
resource "google_compute_instance" "node1" {
 name         = "node1"
 machine_type = "n1-standard-1"
 zone         = "asia-east1-a"
 tags          = ["startup-node"]

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-1604-lts"
     size = 50
   }
 }



// Make sure flask is installed on all new instances for later steps
metadata = {
   foo = "bar"
       startup-script = "${file("${path.module}/startup_script0.sh")}"
       
     }
    service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
}

 network_interface {
   network = "default"

   access_config {
     
     // Include this section to give the VM an external ip address
   }
 }
}
resource "google_compute_instance" "node2" {
 name         = "node2"
 machine_type = "n1-standard-1"
 zone         = "asia-east1-a"
 tags          = ["startup-node"]

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-1604-lts"
     size = 50
   }
 }



// Make sure flask is installed on all new instances for later steps
metadata = {
   foo = "bar"
       startup-script = "${file("${path.module}/startup_script1.sh")}"
       
     }
    service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
}

 network_interface {
   network = "default"

   access_config {
     
     // Include this section to give the VM an external ip address
   }
 }
}
resource "google_compute_instance" "node3" {
 name         = "node3"
 machine_type = "n1-standard-1"
 zone         = "asia-east1-a"
 tags          = ["startup-node"]

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-1604-lts"
     size = 50
   }
 }



// Make sure flask is installed on all new instances for later steps
metadata = {
   foo = "bar"
       startup-script = "${file("${path.module}/startup_script2.sh")}"
       
     }
    service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
}

 network_interface {
   network = "default"

   access_config {
     
     // Include this section to give the VM an external ip address
   }
 }
}
