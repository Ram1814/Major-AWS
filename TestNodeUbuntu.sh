sudo su
sudo apt update
sudo apt upgrade
sudo apt install -y git htop wget
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm --version
nvm install --lts 
node --version
npm -v
cd /home/ubuntu
git clone https://github.com/Ram1814/TaskManager-API.git
cd Task-Manager-API
npm i
echo "" > .env
npm install -g pm2 
pm2 start app.js --name=TaskManager-API
pm2 save     
pm2 startup
sudo apt install nginx
sudo su
rm -f /etc/nginx/sites-available/default
echo "##
# Default server configuration
#
server {
        listen 80 default_server;
        listen [::]:80 default_server;       

        root /home/ubuntu/TaskManager-API;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                # try_files $uri $uri/ =404;
                proxy_pass http://localhost:3000; #whatever port your app runs on
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;

        }       
}  
" > /etc/nginx/sites-available/default
sudo nginx -t
sudo service nginx restart
