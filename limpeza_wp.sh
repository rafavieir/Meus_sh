#!/bin/bash

limpeza_wp() {
    mv public_html public_html_old
    echo "... pasta public renomeada \n"
    mkdir public_html
    echo "... pasta public recriada \n"
    cd public_html
    curl -SO https://br.wordpress.org/latest-pt_BR.zip && unzip latest-pt_BR.zip && rm latest-pt_BR.zip && mv wordpress/* . && rm -r wordpress
    curl -q https://raw.githubusercontent.com/euforo/Meus_sh/main/htacc.sh > ht.sh && sh ht.sh
    echo "... wp e htaccess renovados \n"
    rm ht.sh
    rm -r wp-content
    
    rm wp-config-sample.php
    echo "copiando arquivos para novo wp"
    cp -r ../public_html_old/wp-content .
    cp ../public_html_old/wp-config.php .
    echo "feito!"
    
}



limpeza_wp
