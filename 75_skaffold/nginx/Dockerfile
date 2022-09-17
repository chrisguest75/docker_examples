# A simple nginx server running as non-root user
FROM nginx:1.23.1 as PRODUCTION
LABEL dockerfile.baseimage="nginx:1.23.1" dockerfile.description="nginx-test" dockerfile.stage="PRODUCTION"

## add permissions for nginx user
RUN chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

## switch to non-root user
USER nginx
ENV PORT=80
WORKDIR /work
COPY bootstrap.sh /work/bootstrap.sh

WORKDIR /usr/share/nginx/html
COPY index.html ./

CMD ["/bin/sh", "-c", "/work/bootstrap.sh"]