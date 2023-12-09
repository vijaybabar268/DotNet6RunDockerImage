# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./API/API.csproj" --disable-parallel
RUN dotnet publish "./API/API.csproj" -c release -o /app --no-restore

# Serve Stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0-focal
WORKDIR /app
COPY --from=build /app ./

EXPOSE 80
EXPOSE 443

ENTRYPOINT [ "dotnet", "API.dll" ]

# DOTNET CLI Commands to create, build and run .net project
# -> dotnet --info
# -> dotnet new list
# -> dotnet new sln
# -> dotnet new webapi -n API
# -> dotnet sln add API
# -> dotnet clean
# -> dotnet restore
# -> dotnet build
# -> dotnet run or dotnet watch run

# Create and Run docker image inside container
# Add Docekerfile at root sln level
# -> docker build --rm -t my-docker-image:latest .
# -> docker ps -a
# -> docker run -it --rm -p 6002:80 my-docker-image:latest
# -> docker ps -a