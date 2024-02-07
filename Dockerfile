# Use the official Nginx base image
FROM nginx:latest

# Install procps package (for ps commands)
RUN apt-get update && \
    apt-get install -y procps && \
    rm -rf /var/lib/apt/lists/*
# Run NGINX as a non-root user (user 1000)
#RUN useradd -u 1000 nginx-user && \
 #   chown -R nginx-user:nginx-user /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html /etc/nginx/conf.d
#RUN chmod 777 /etc/nginx/conf.d
# Copy local nginx.conf file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy a local website into the container
COPY index.html /usr/share/nginx/html/

# Direct NGINX to use /tmp subfolder for all writable outputs
RUN ln -sf /tmp /var/cache/nginx && \
    ln -sf /tmp /var/run && \
    ln -sf /tmp /var/log/nginx

# Expose port 80 for NGINX
EXPOSE 80

# Run NGINX with the non-root user
#USER nginx-user

# Command to start NGINX
CMD ["nginx", "-g", "daemon off"]
