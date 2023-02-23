# Use the latest Windows Server Core image as the base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019
#FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

# Install .NET
ENV DOTNET_VERSION=6.0.0

RUN powershell -Command \
        $ErrorActionPreference = 'Stop'; \
        $ProgressPreference = 'SilentlyContinue'; \
        Invoke-WebRequest -OutFile dotnet.zip https://dotnetcli.azureedge.net/dotnet/Runtime/$Env:DOTNET_VERSION/dotnet-runtime-$Env:DOTNET_VERSION-win-x64.zip; \
        Expand-Archive dotnet.zip -DestinationPath dotnet; \
        Remove-Item -Force dotnet.zip

        # $dotnet_sha512 = '2b6b630b4f0d86f4decfd1a8c2186f14322c792bafb024a8e71919ac8918e29dec99004a5cdf8b22479e0f16af582a90ed521d312a0a67a75ed5bd4adbb7594a'; \
        # if ((Get-FileHash dotnet.zip -Algorithm sha512).Hash -ne $dotnet_sha512) { \
        #     Write-Host 'CHECKSUM VERIFICATION FAILED!'; \
        #     exit 1; \
        # }; \
        # \

# Set the working directory to C:\app
WORKDIR C:\\app

# Copy the application files into the container
COPY .\\main.cs .

# Compile the application
RUN csc /out:main.exe .\\main.cs

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Run the application when the container starts
CMD ["main.exe"]