@echo off

:limpeza_wp
    rename public_html public_html_old
    echo Renomeando a pasta public...
    mkdir public_html
    echo Recriando a pasta public...
    cd public_html
    curl -o latest-pt_BR.zip -L https://br.wordpress.org/latest-pt_BR.zip
    7z x latest-pt_BR.zip -olatest
    del latest-pt_BR.zip
    move latest\* .
    rmdir /s /q latest
    curl -o ht.bat -L https://raw.githubusercontent.com/euforo/Meus_sh/main/htacc.bat
    call ht.bat
    echo Atualizando o WordPress e o arquivo .htaccess...
    del ht.bat
    rmdir /s /q wp-content
    del wp-config-sample.php
    echo Copiando arquivos para o novo WordPress...
    copy /y ..\public_html_old\wp-content . /s
    copy /y ..\public_html_old\wp-config.php .
    echo Feito!

goto :eof

:EOF
