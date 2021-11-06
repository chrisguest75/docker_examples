FROM nginx:1.21.3 as PRODUCTION
LABEL dockerfile.baseimage="nginx:1.21.3" dockerfile.description="nginx-test" dockerfile.stage="PRODUCTION"

# ## add permissions for nginx user
# RUN chown -R nginx:nginx /var/cache/nginx && \
#         chown -R nginx:nginx /var/log/nginx && \
#         chown -R nginx:nginx /etc/nginx/conf.d
# RUN touch /var/run/nginx.pid && \
#         chown -R nginx:nginx /var/run/nginx.pid

WORKDIR /work
COPY bootstrap.sh /work/bootstrap.sh
# RUN chown -R nginx:nginx /work

WORKDIR /usr/share/nginx/html
COPY index.html ./
# RUN chown -R nginx:nginx /usr/share/nginx/html

# ## switch to non-root user
# USER nginx

ENV PORT=80


CMD ["/bin/sh", "-c", "/work/bootstrap.sh"]