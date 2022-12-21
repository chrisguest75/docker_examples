# syntax=docker/dockerfile:1.4
FROM nginx:1.23.1 

COPY <<EOF /usr/share/nginx/html/index.html
<html>
    <head>
        <title>Hello from Docker</title>
    </head>
    <body>
        <h1>Hello from Docker</h1>
        <p>Built inside an image</p>
    </body>
</html>
EOF



