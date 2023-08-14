#include /bin/bash

mv php.ini php.ini_cliente123 && cp /etc/php.ini . &&
sed -i 's/max_execution_time = 30/max_execution_time = 90/' php.ini &&
sed -i 's/max_input_time = 60/max_input_time = 90/' php.ini &&
sed -i 's/memory_limit = 32M/memory_limit = 512M/' php.ini &&
sed -i 's/post_max_size = 8M/post_max_size = 512M/' php.ini &&
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 512M/' php.ini &&
sed -i '954i session.save_path = "/home/'$USER'/tmp"' php.ini &&
sed -i '955d' php.ini

curl -k -q https://raw.githubusercontent.com/euforo/Meus_sh/main/.htaccess > ~/public_html/.htaccess
me="$USER"
sed -i 's|home/$USER|home/'"$me"'|' ~/public_html/.htaccess

sed -i '9 iadd_filter("'https_ssl_verify'", "'__return_false'");' ~/public_html/wp-includes/functions.php
