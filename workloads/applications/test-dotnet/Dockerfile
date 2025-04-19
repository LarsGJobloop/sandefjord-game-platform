FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /App

COPY . ./
RUN dotnet restore
RUN dotnet publish --configuration Release --output out test-dotnet.csproj

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /App
COPY --from=build /App/out .
ENTRYPOINT ["dotnet", "test-dotnet.dll"]