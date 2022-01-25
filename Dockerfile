# httpd 24 server
FROM httpd:2.4

# Copy content
COPY ./output/ /usr/local/apache2/htdocs/