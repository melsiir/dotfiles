function page --wraps='html; css; js' --wraps=html\;\ css\;\ js\;\ print\ \'The\ template\ created\ successfully\ ✅\'\  --wraps=html\;\ css\;\ js\;\ printf\ \'The\ template\ created\ successfully\ ✅\'\  --wraps=html\;\ css\;\ js\;\ echo\ \'The\ template\ created\ successfully\ ✅\'\  --description alias\ page=html\;\ css\;\ js\;\ echo\ \'The\ template\ created\ successfully\ ✅\'\ 
    html

    echo '* {

}

' >>styles.css

    touch main.js
    echo 'The template created successfully ✅' $argv
end
