$version = "0.24.0"

& docker build --build-arg BASE_VERSION=$version -f Dockerfile.cpu . -t squidex/deepdetect_cpu:$version -t squidex/deepdetect_cpu:latest

& docker push squidex/deepdetect_cpu:$version
& docker push squidex/deepdetect_cpu

& docker build --build-arg BASE_VERSION=$version -f Dockerfile.gpu . -t squidex/deepdetect_gpu:$version -t squidex/deepdetect_gpu

& docker push squidex/deepdetect_gpu:$version
& docker push squidex/deepdetect_gpu