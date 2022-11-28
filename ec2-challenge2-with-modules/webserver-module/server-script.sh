sudo apt-get update -y 
sudo apt-get install apache2 -y
sudo systemctl status apache2
sudo systemctl start apache2
echo "<h1>Hello from Terraform" | sudo tee /var/www/html/index.html