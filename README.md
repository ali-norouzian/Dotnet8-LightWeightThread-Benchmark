# Dotnet8-LightWeightThread-Benchmark

1. Build docker image on root of project where dockerfile is located :
```
docker build . -f .\Dockerfile -t dotnet-bench:v1
```

2. Run it on your port :
```
docker run -p <YOUR_TARGET_PORT_IN_YOUR_LOCALHOST>:8080 --name dotnet-bench -d dotnet-bench:v1
```
