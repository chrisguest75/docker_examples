# Use the latest Windows Server Core image as the base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set the working directory to C:\app
WORKDIR C:\app

# Copy the application files into the container
COPY app .

# Compile the application
RUN csc main.cs

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Run the application when the container starts
CMD ["main.exe"]