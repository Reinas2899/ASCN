#!/bin/bash

if [ "$MIGRATESEED" == "true" ] 
then
  php artisan migrate --seed
fi

php artisan serve --host=0.0.0.0