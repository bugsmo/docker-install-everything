# docker-install-everything

> install all environments using docker-compose.
> 使用 docker-compose 安装各种服务。

快速安装 docker && docker-compose
```shell

```

## 项目特色

- 仅依赖 docker 和 docker-compose，无需本地复杂环境。
- 支持软件和服务多，并且在持续新增。
- 每个文件夹一组(套)服务，根据需要安装即可。
- 所有的文件夹相互独立，无互相依赖，降低使用难度。

## 使用方法

```
git clone https://github.com/FX-Max/docker-install-everything.git
cd docker-install-everything
# 进入里想要安装的服务文件夹后，按照文件夹内的 README 文件介绍使用。
# 以安装 redis 为例：
cd redis
# 根据目录下 README 中的说明操作即可
docker-compose up -d redis
```

## 支持列表

- apollo

    简要说明: [Apollo](https://github.com/apolloconfig/apollo/) 是一款可靠的分布式配置管理中心，诞生于携程框架研发部。

- beanstalkd

    简要说明: [beanstalkd](https://beanstalkd.github.io/)，高性能，轻量级的分布式内存队列。

- drawio

    简要说明: [drawio](https://github.com/jgraph/drawio)是一款强大、免费的绘图工具。