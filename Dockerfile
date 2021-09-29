# Estágio 1: build
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source
COPY *.sln .
COPY ConversaoPeso.Web/*.csproj ./ConversaoPeso.Web/
RUN dotnet restore
COPY ConversaoPeso.Web/. ./ConversaoPeso.Web/
WORKDIR /source/ConversaoPeso.Web
RUN dotnet publish -c release -o /app --no-restore

# Estágio 2: run
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS run
WORKDIR /app
COPY --from=build /app ./
CMD [ ""dotnet", "ConversaoPeso.Web.dll"" ]