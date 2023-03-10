# Bash script for a single node install of Rancher on K3s

When fully functional, the script will

- Install a K3s server (v1.24.9)
- Set appropriate perms for the /var/lib/rancher/k3s/server/manifests directory
- Create a rancher.yaml file
- Install Rancher (v2.7.0) on k3s

Inspired by [this script](https://gist.github.com/brandond/a171a2d2633ccb124f53129315a5970b) by [Brad Davidson](https://gist.github.com/brandond) and [this script](https://github.com/ibrokethecloud/k3s-rancher-bootstrap) by [Gaurav Mehta](https://github.com/ibrokethecloud/).
