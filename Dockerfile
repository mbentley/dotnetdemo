 # Stage 1
 FROM microsoft/dotnet:2.1-sdk AS builder
 WORKDIR /source

 # caches restore result by copying csproj file separately
 COPY ./dotnetdemo/dotnetdemo.csproj .
 RUN dotnet restore

 # copies the rest of your code
 COPY ./dotnetdemo/. .
 RUN dotnet publish --output /app/ --configuration Release

 # Stage 2
 FROM microsoft/dotnet:2.1-aspnetcore-runtime
 WORKDIR /app
 COPY --from=builder /app .
 ENTRYPOINT ["dotnet", "dotnetdemo.dll"]
