FROM nginx:alpine

# Copy static site and nginx config template
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/templates/default.conf.template

# LLM_ENDPOINT is substituted at container start by nginx docker entrypoint
# Set this in your Helm values: e.g. https://my-llm.pcai.danofficeit.com/v1
ENV LLM_ENDPOINT=http://localhost:8080

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ || exit 1

EXPOSE 80

# nginx official image automatically runs envsubst on /etc/nginx/templates/*.template
# and writes results to /etc/nginx/conf.d/ before starting nginx
CMD ["nginx", "-g", "daemon off;"]
