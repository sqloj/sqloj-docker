# SQLOJ

本项目采用了 Docker 容器化技术，部署起来更加方便。

### Deploy 部署

请确认已经安装 [docker](https://docs.docker.com/engine/) 和 [docker-compose](https://docs.docker.com/compose/)。仅在 Linux 系统上测试过。

建立并进入一个空文件夹，接下来所有操作都在该文件夹中进行。

下载本项目的 `docker-compose.yml` 文件。

```shell
$ wget http://124.221.134.229:8888/amall-group/amall-docker/raw/branch/main/docker-compose.yml
```

### Run 运行

请仔细检查配置参数，确认无误后运行

```shell
$ sudo docker-compose up -d
```

接下来打开 http://localhost:8888/swagger-ui/index.html 即可看到。

如果需要更新镜像版本，只需

```shell
$ sudo docker-compose stop   # 停止服务
$ sudo docker-compose pull   # 拉取新镜像
$ sudo docker-compose up -d  # 重新运行
```

### Build 构建

请检查 `makefile` 中的变量 `backend_path` 是否指向后端代码路径。

首先构建工程

```shell
$ make build -B # 参数 -B 是为了强制执行
```

接下来打包镜像

```shell
$ sudo make docker -B
```

（可选）测试镜像

```shell
$ sudo make test
```

（可选）上传镜像到 Docker Hub。

```shell
$ sudo make push
```

