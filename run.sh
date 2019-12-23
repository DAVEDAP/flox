#!/bin/bash

cat /flox/backend/.env

sed -i 's/TMDB_API_KEY=/TMDB_API_KEY=5478a5e17f0dc1a39c67c533b9451893/g' flox/backend/.env
sed -i 's/DB_HOST=.*/DB_HOST=db/g' /flox/backend/.env
sed -i 's/DB_DATABASE=/DB_DATABASE=flox/g' /flox/backend/.env
sed -i 's/DB_USERNAME=/DB_USERNAME=root/g' /flox/backend/.env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=password/g' /flox/backend/.env

php artisan flox:db --fresh admin admin
cd /flox/client && npm install && npm run build

