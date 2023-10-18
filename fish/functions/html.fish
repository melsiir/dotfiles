function html --wraps=echo\ \'\<!DOCTYPE\ html\>\n\<html\ lang=\"en\"\>\n\ \ \<head\>\n\ \ \ \ \<title\>\</title\>\n\ \ \ \ \<meta\ charset=\"UTF-8\"\>\n\ \ \ \ \<meta\ name=\"viewport\"\ content=\"width=device-width,\ initial-scale=1\"\>\n\ \ \ \ \<link\ href=\"style.css\"\ rel=\"stylesheet\"\>\n\ \ \</head\>\n\ \ \<body\>\n\ \ \n\ \ \<script\ src=\"main.js\"\>\</script\>\ \n\ \ \</body\>\n\</html\>\'\ \>\>\ index.html --description alias\ html=echo\ \'\<!DOCTYPE\ html\>\n\<html\ lang=\"en\"\>\n\ \ \<head\>\n\ \ \ \ \<title\>\</title\>\n\ \ \ \ \<meta\ charset=\"UTF-8\"\>\n\ \ \ \ \<meta\ name=\"viewport\"\ content=\"width=device-width,\ initial-scale=1\"\>\n\ \ \ \ \<link\ href=\"style.css\"\ rel=\"stylesheet\"\>\n\ \ \</head\>\n\ \ \<body\>\n\ \ \n\ \ \<script\ src=\"main.js\"\>\</script\>\ \n\ \ \</body\>\n\</html\>\'\ \>\>\ index.html
  echo '<!DOCTYPE html>
<html lang="en">
  <head>
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="style.css" rel="stylesheet">
  </head>
  <body>
  
  <script src="main.js"></script> 
  </body>
</html>' >> index.html $argv; 
end
