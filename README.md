# ghost-sae

> 此项目示例如何通过[Sina App Engine](http://www.sinacloud.com/sae.html)和Dockerfile构建一个Ghost博客。

### 第1步 创建云应用SAE

进入云应用SAE控制台，在“应用管理”中点击“+创建新应用”，然后就会进入如下应用创建页面

![创建云应用](/create-sae.png)

> 开发语言选“自定义”，部署环境选“Dockerfile”，环境配置和实例个数我建议先选1个基础配置就可以了，这个配置可以在部署成功以后随时根据实际需求来调整的，当然越多越高的配置也相应会有更多的支出。


### 第2步 数据库及存储

云应用创建成功，进入云应用管理，接下来我们要申请数据库和存储，虽然容器有5G的空间，你完全可以使用sqlite作为数据库，把内容数据和文件都保存在这个容器中，但问题是，只要你更新Dockerfile，容器就会重新构建，你的数据也就没了！所以就不要吝啬这点投入了，在“数据库与缓存服务”中，创建一个“共享型MySQL”，当然，够豪的话，你也可以创建独享型MySQL；在“存储与CDN服务”中新建一个“共享存储”，容量视个人需求而定吧，反正也是随时可以调整的。这个存储在后续的步骤中是要挂载到容器上的。

在“应用”>>“环境变量”中“+添加环境变量”，变量名“GHOST_URL”，值为你的SAE网址，比如“`http://yourapp.applinzi.com/`”，该配置可以用于以后绑定独立域名。

### 第3步 定制你的Dockerfile

本示例中的Dockerfile可以直接在SAE中使用，也可以根据你的自身需要进行定制修改（比如mail的配置）。其中build.sh、run.sh和env-dev.list可以用于在本地开发环境中测试并验证构建过程（当然首先你本地要有Docker环境）。

生成镜像（docker build）：
```bash
$ ./build.sh
```

运行容器（docker run）：
```bash
$ ./run.sh
```

### 最后 push代码

`git commit` & `git push`你的代码，如果一切顺利，在push收到成功的信息后，就可以访问你的Ghost了。

别忘了把你的“共享存储”挂载到Dockerfile中$GHOST_CONTENT所指定的路径上并重启容器。

Enjoy!
