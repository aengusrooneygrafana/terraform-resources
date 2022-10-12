docker run -d -p 3000:3000 --name grafana grafana/grafana

navigate to http://localhost:3000 and log in. The default Grafana username and password is admin. Once logged in, we need to navigate to Configuration –> API Keys or click here http://localhost:3000/org/apikeys 

create a new key with ADMIN permissions 

copy the token into main.tf 

terraform init 
terraform apply 

