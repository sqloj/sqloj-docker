# SQLOJ

本项目采用了 Docker 容器化技术，部署起来更加方便。

## Deploy 部署

请确认已经安装 [docker](https://docs.docker.com/engine/) 和 [docker-compose](https://docs.docker.com/compose/)。仅在 Linux 系统上测试过。

建立并进入一个空文件夹，接下来所有操作都在该文件夹中进行。

下载本项目的 `docker-compose.yml` 文件。

```shell
$ git clone https://github.com/sqloj/sqloj-docker.git
```

## Run 运行

在 `compose` 目录下，已经准备好了一些 `docker-compose.yml` 配置，具体有

- `test`（**推荐**），包括前端后端和 h2 数据库的评测端。
- `core`，包括前端和后端，不包括评测端。
- `judge-h2`，h2 数据库的评测端。
- `judge-mariadb`，mariadb 数据库的评测端。

请根据需要选择合适的配置。

### Test 测试

没有特殊要求的情况下，推荐使用本配置。

本配置包括前端后端和 h2 数据库的评测端，评测端会自动加入后端的数据库中。

请仔细检查配置参数，确认无误后运行

```shell
$ cd compose/test
$ sudo docker-compose up -d
```

接下来打开 http://localhost:10085/ 即可看到。

如果需要更新镜像版本，只需

```shell
$ sudo docker-compose stop   # 停止服务
$ sudo docker-compose pull   # 拉取新镜像
$ sudo docker-compose up -d  # 重新运行
```

## Core 前后端配置

如果只需要前端和后端，可以执行

```shell
$ cd compose/core
$ sudo docker-compose up -d
```

接下来打开 http://localhost:10085/ 即可看到。

## Judge Server 评测服务器

添加额外的测评服务器大同小异，基本都是启动数据库和其伴生的 Java Wrapper。

接下来以 mariadb 为例

```shell
$ cd compose/judge-mariadb
$ sudo docker-compose up -d
```

### Build 构建镜像

首先请拉下来所需的代码，并在 `src/makefile` 中修改变量 `**_path` 使其指向正确路径。

接下来执行对应的构建

```shell
# 例如构建前端
$ make frontend -B  # 参数 -B 是为了强制执行
# 如果需要构建全部项目
$ make build -B
```

接下来打包镜像
```shell
$ make docker -B
```

（可选）测试镜像

```shell
$ make test
```

（可选）上传镜像到 Docker Hub。

```shell
$ make push
```

