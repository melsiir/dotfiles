curl cheat.sh/curl~post/i

cheat.sheets:curl

# POST to a form.

curl -F "name=user" -F "password=test" <http://example.com>

# POST JSON Data

curl -H "Content-Type: application/json" -X POST -d '{"user":"bob","pass":"123"}' <http://example.com>

curl -i -X POST --json "{\"name\":\"imac\",\"price\":779,\"image\":\"nimage\"}" <http://localhost:3000/add_product>

# post json data from a file

curl -X POST <http://localhost:3000/add_product> --json @data.json

or

cat data.json | curl -X POST <http://localhost:3000/add_product> --json @-

or

curl --json @- localhost:3000/add_product < data.json

# POST data from the standard in / share data on sprunge.us

curl -F 'sprunge=<-' sprunge.us

tldr:curl

# Send form-encoded data (POST request of type `application/x-www-form-urlencoded`). Use `--data @file_name` or `--data @'-'` to read from STDIN

curl --data 'name=bob' <http://example.com/form>

# multiple data submission

curl -d "first=Ted" -d "last=Young" <http://api.example.com:8080/customers>
curl -d "first=Ted&last=Young" <http://api.example.com:8080/customers>

# basic auth

curl -u name:password --basic <https://example.com>

tldr:curlie

# Send a POST request

curlie post httpbin.org/post name=john age:=25

#### curlie

## you want more documentation for curlie you can chech httpie documentation since curlie inspired by httpie their docs have some similerty the same

# Simple GET

curlie -v example.com

# POST simple JSON with headers

curlie -v POST httpbin.org/status/201 "Authorization: Bearer xxxx" "name=John Doe"

this is also json

curlie post localhost:3000/api/products name=iphone price=977 image=noimage

# POST large JSON

curlie -v POST httpbin.org/status/201 "Authorization: Bearer xxxx" -d '
[
{
"name": "John Doe"
}
]
'

# adding headers

curlie <https://httpbin.dev/headers> Content-Type:"application/json"

# Cookies

cookies can be added by appending them to a Cookie header with the name and value pairs:

Curlie <https://httpbin.dev/cookies> Cookie:some_cookie=foo

# basic auth

To set basic authentication with Curlie, we can use the --user or -u options:

curlie --user user:passwd --basic <https://httpbin.dev/basic-auth/user/passwd>

### JSON

httpie
name=John \ # String (default)
age:=29 \ # Raw JSON — Number
married:=false \ # Raw JSON — Boolean
hobbies:='["http", "pies"]' \ # Raw JSON — Array
favorite:='{"tool": "HTTPie"}' \ # Raw JSON — Object
bookmarks:=@files/data.json \ # Embed JSON file
description=@files/text.txt # Embed text file

### Raw JSON

For very complex JSON structures, it may be more convenient to pass it as raw request body, for example:

echo -n '{"hello": "world"}' | http POST pie.dev/post
Run
http POST pie.dev/post < files/data.json

### Authentication

# basic

http -a username:password pie.dev/basic-auth/username/password

# Digest auth

http -A digest -a username:password pie.dev/digest-auth/httpie/username/password

# Bearer auth

https -A bearer -a token pie.dev/bearer
