FROM alpine:3.19

# Install bash and iputils for ping execution
RUN apk add --no-cache bash iputils

# Set working directory
WORKDIR /app

# Copy application files
COPY app/ .

# Ensure executable permissions inside image
RUN chmod +x /app/*.sh

# Define healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD /app/health-check.sh || exit 1

# Default entrypoint
ENTRYPOINT ["/app/diagnostic.sh"]
CMD ["help"]
