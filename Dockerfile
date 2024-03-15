# Use the ASP.NET Core SDK for building the app
FROM mcr.microsoft.com/dotnet/sdk:8.0.202-alpine3.19 AS build-env
WORKDIR /app
EXPOSE 80

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0.3-alpine3.19-composite
WORKDIR /app
COPY --from=build-env /app/out .

ENV WAITINGSERVER_URL="http://host.docker.internal:8000"
# RUNNING_PORT is just for terminal printing. set exposed port in docker run
ENV RUNNING_PORT="8001"

ENTRYPOINT ["dotnet", "cs.dll"]
