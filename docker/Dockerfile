# Use the official Crystal image as the base
FROM crystallang/crystal:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Crystal app into the container
COPY ./app /usr/src/app

# Install dependencies
RUN shards install

# Compile the Crystal application
RUN crystal build src/main.cr --release

# Expose port 8080 for the application
EXPOSE 8080

# Set environment variables for NODE_NUMBER and PORT (defaults can be overridden)
ENV NODE_NUMBER="01"
ENV PORT=8080

# Run the compiled application
CMD ["./main"]
