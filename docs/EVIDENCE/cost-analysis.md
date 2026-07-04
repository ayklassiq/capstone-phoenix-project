# Cost Analysis

This deployment uses **K3s on AWS EC2** with **Argo CD**,
**PostgreSQL**, and **nip.io** for DNS (no domain purchase required).

## Monthly Itemized Cost

  Item                  Spec                              Qty                 \$/mo
  --------------------- ------------------------------- ----- ---------------------
  Control-plane VM      EC2 t3.small                        1               \$16.79
  Worker VMs            EC2 t3.small                        2               \$33.58
  Load Balancer         AWS Application Load Balancer       1               \$18.00
  Block Storage (PVC)   20 GB EBS gp3                       1                \$1.60
  Object Storage        S3 (Terraform state/backups)        1                \$1.00
  DNS / Domain          **nip.io**                          1            **\$0.00**
  **Total**                                                     **≈ \$70.97/month**

## Compared to the Single-Server Docker Compose + Portainer Deployment

-   **Single-server Docker Compose + Portainer:** ≈ **\$18--20/month**
-   **Kubernetes (K3s) Cluster:** ≈ **\$70.97/month**

### What the Extra Spend Buys

Although the Kubernetes cluster costs around three to four times more
than a single-server deployment, it provides production-grade
capabilities including:

-   High Availability through multiple worker nodes.
-   Zero-downtime deployments using rolling updates.
-   Self-healing by automatically restarting failed Pods.
-   GitOps deployments using Argo CD.
-   Horizontal scalability using replicas and Horizontal Pod Autoscaler
    (HPA).
-   Better operational reliability for production workloads.

For small personal projects, prototypes, or low-traffic websites, these
features may not justify the additional infrastructure cost. A single
Docker Compose server is usually the more economical option.

## How I'd Halve This Cost

To reduce costs, I would use Spot Instances for the worker nodes while
keeping the control-plane node on an On-Demand instance for stability. I
could also reduce the control-plane instance size if resource usage
remains low or use a two-node K3s cluster for development environments.
Since this project uses **nip.io**, there is no recurring DNS cost.
Sharing a single load balancer and minimizing storage allocations would
further reduce infrastructure costs while maintaining most Kubernetes
functionality.
