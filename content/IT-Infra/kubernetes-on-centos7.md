+++
title = "k8s - CentOS7 - Installation"
description = ""
weight = 1

+++

# kubernetes installation on Centos7

*介绍下环境，4个节点的情况如下：*

| 节点名 | IP          | OS      | 安装软件                          |
| ------ | ----------- | ------- | --------------------------------- |
| Master | 10.211.55.6 | Centos7 | kubeadm，kubelet，kubectl，docker |
| Node1  | 10.211.55.7 | Centos7 | kubeadm，kubelet，kubectl，docker |
| Node2  | 10.211.55.8 | Centos7 | kubeadm，kubelet，kubectl，docker |
| Node3  | 10.211.55.9 | Centos7 | kubeadm，kubelet，kubectl，docker |

*其中kubeadm,kubectl,kubelet的版本为v1.10.0，docker的版本为1.13.1。*



***一.各节点前期的准备工作：***



*1.关闭并停用防火墙*

​    *systemctl stop firewalld.service*

​    *systemctl disable firewalld.service*

*2.永久关闭SELinux*

​    *vim /etc/selinux/config*

​    *SELINUX=disabled*

*3.同步集群系统时间*

​    *yum -y install ntp*

​    *ntpdate 0.**asia.pool.ntp.org*

*4.重启机器*

​    *reboot*



***二.软件安装与配置：***



***注意⚠️****：软件源按需配置，下面给出3个源，其中kubernetes yum源必须配置，docker源如果需要安装docker-ce版本则需要安装，否则最高支持1.13.1版本。*



| #阿里云yum源：    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo    yum clean all    yum makecache |
| ------------------------------------------------------------ |
| #docker yum源    cat >> /etc/yum.repos.d/docker.repo <<EOF    [docker-repo]    name=Docker Repository    baseurl=http://mirrors.aliyun.com/docker-engine/yum/repo/main/centos/7    enabled=1    gpgcheck=0    EOF |
| #kubernetes yum源    cat >> /etc/yum.repos.d/kubernetes.repo <<EOF    [kubernetes]    name=Kubernetes    baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/    enabled=1    gpgcheck=0    EOF |

*配置完源，安装软件：*

​    *yum -y install docker kubeadm kubelet kubectl*

*关闭SWAP*

​    *swapoff -a*

*启动docker并设为开机启动：*

​    *systemctl start docker*

​    *systemctl enable docker*

***参数配置：***

*kubelet的cgroup驱动参数需要和docker使用的一致，先查询下docker的cgroup驱动参数：*

​    *docker info |grep cgroup*

*在docker v1.13.1下，该参数默认为systemd，所以更改kubelet的配置参数：*

​    *sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf*

*载入配置，启动kubelet：*

​    *systemctl daemon-reload*

​    *systemctl start kubelet*

***注意⚠️****：在启动kubeadm之前，一定要先启动kubelet，否则会显示连接不上。*



*下面开始，分别操作Master节点和Node节点：*

*启动Master节点：*

​    *kubeadm init --kubernetes-version=1.10.0 --token-ttl 0 --pod-network-cidr=10.244.0.0/16*

*该命令表示kubenetes集群版本号为v1.10.0，token的有效时间为0表示永久有效，容器的网络段为10.244.0.0/16，由于kubeadm安装方式只能用于建立最小可用集群，所以很多addon是没有集成的，包括网络插件，需要之后安装，但网段参数需要先行配置。*



***注意⚠️****：kubenetes目前的版本较之老版本，最大区别在于核心组件都已经容器化，所以安装的过程是会自动pull镜像的，但是由于镜像基本都存放于谷歌的服务器，墙内用户是无法下载，导致安装进程卡在****[init] This often takes around a minute; or longer if the control plane images have to be pulled*** *，这里我提供两个思路：*

*1.有个墙外的代理服务器，对docker配置代理，需修改/etc/sysconfig/docker文件，添加：*

​    *HTTP_PROXY=**http://proxy_ip:port*

​    *http_proxy=$HTTP_PROXY*

   *重启docker：systemctl restart docker*

*2.事先下载好所有镜像，下面我给出v1.10.0版本**基本安装**下所需要的所有镜像（其他版本所需的镜像版本可能不同，以官方文档为准）：*

| Master节点所需镜像：                                         |
| ------------------------------------------------------------ |
| k8s.gcr.io/kube-apiserver-amd64:v1.10.0k8s.gcr.io/kube-scheduler-amd64:v1.10.0k8s.gcr.io/kube-controller-manager-amd64:v1.10.0k8s.gcr.io/kube-proxy-amd64:v1.10.0k8s.gcr.io/etcd-amd64:3.1.12k8s.gcr.io/k8s-dns-dnsmasq-nanny-amd64:1.14.8k8s.gcr.io/k8s-dns-sidecar-amd64:1.14.8k8s.gcr.io/k8s-dns-kube-dns-amd64:1.14.8k8s.gcr.io/pause-amd64:3.1quay.io/coreos/flannel:v0.9.1-amd64 （为网络插件的镜像，这里选择flannel为网络插件） |
| Node节点所需镜像：                                           |
| k8s.gcr.io/kube-proxy-amd64:v1.10.0k8s.gcr.io/pause-amd64:3.1quay.io/coreos/flannel:v0.9.1-amd64（为网络插件的镜像，这里选择flannel为网络插件） |

*Master节点安装成功会输出如下内容：*



*[root@master kubelet.service.d]# kubeadm reset*

*[preflight] Running pre-flight checks.*

*[reset] Stopping the kubelet service.*

*[reset] Unmounting mounted directories in "/var/lib/kubelet"*

*[reset] Removing kubernetes-managed containers.*

*[reset] Deleting contents of stateful directories: [/var/lib/kubelet /etc/cni/net.d /var/lib/dockershim /var/run/kubernetes /var/lib/etcd]*

*[reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]*

*[reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]*

*[root@master kubelet.service.d]# kubeadm init --kubernetes-version=1.10.1 --pod-network-cidr=10.244.0.0/16 --skip-preflight-checks*

*Flag --skip-preflight-checks has been deprecated, it is now equivalent to --ignore-preflight-errors=all*

*[init] Using Kubernetes version: v1.10.1*

*[init] Using Authorization modes: [Node RBAC]*

*[preflight] Running pre-flight checks.*

​	*[WARNING Service-Kubelet]: kubelet service is not enabled, please run 'systemctl enable kubelet.service'*

​	*[WARNING FileExisting-crictl]: crictl not found in system path*

*Suggestion: go get github.com/kubernetes-incubator/cri-tools/cmd/crictl*

*[certificates] Generated ca certificate and key.*

*[certificates] Generated apiserver certificate and key.*

*[certificates] apiserver serving cert is signed for DNS names [master.kube kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.0.130]*

*[certificates] Generated apiserver-kubelet-client certificate and key.*

*[certificates] Generated etcd/ca certificate and key.*

*[certificates] Generated etcd/server certificate and key.*

*[certificates] etcd/server serving cert is signed for DNS names [localhost] and IPs [127.0.0.1]*

*[certificates] Generated etcd/peer certificate and key.*

*[certificates] etcd/peer serving cert is signed for DNS names [master.kube] and IPs [192.168.0.130]*

*[certificates] Generated etcd/healthcheck-client certificate and key.*

*[certificates] Generated apiserver-etcd-client certificate and key.*

*[certificates] Generated sa key and public key.*

*[certificates] Generated front-proxy-ca certificate and key.*

*[certificates] Generated front-proxy-client certificate and key.*

*[certificates] Valid certificates and keys now exist in "/etc/kubernetes/pki"*

*[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/admin.conf"*

*[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/kubelet.conf"*

*[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/controller-manager.conf"*

*[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/scheduler.conf"*

*[controlplane] Wrote Static Pod manifest for component kube-apiserver to "/etc/kubernetes/manifests/kube-apiserver.yaml"*

*[controlplane] Wrote Static Pod manifest for component kube-controller-manager to "/etc/kubernetes/manifests/kube-controller-manager.yaml"*

*[controlplane] Wrote Static Pod manifest for component kube-scheduler to "/etc/kubernetes/manifests/kube-scheduler.yaml"*

*[etcd] Wrote Static Pod manifest for a local etcd instance to "/etc/kubernetes/manifests/etcd.yaml"*

*[init] Waiting for the kubelet to boot up the control plane as Static Pods from directory "/etc/kubernetes/manifests".*

*[init] This might take a minute or longer if the control plane images have to be pulled.*

*[apiclient] All control plane components are healthy after 55.004934 seconds*

*[uploadconfig] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace*

*[markmaster] Will mark node master.kube as master by adding a label and a taint*

*[markmaster] Master master.kube tainted and labelled with key/value: node-role.kubernetes.io/master=""*

*[bootstraptoken] Using token: e9m9do.jvfdl5dti279cf59*

*[bootstraptoken] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials*

*[bootstraptoken] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token*

*[bootstraptoken] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster*

*[bootstraptoken] Creating the "cluster-info" ConfigMap in the "kube-public" namespace*

*[addons] Applied essential addon: kube-dns*

*[addons] Applied essential addon: kube-proxy*





*Your Kubernetes master has initialized successfully!*



*To start using your cluster, you need to run the following as a regular user:*



  *mkdir -p $HOME/.kube*

  *sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config*

  *sudo chown $(id -u):$(id -g) $HOME/.kube/config*



*You should now deploy a pod network to the cluster.*

*Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:*

  *https://kubernetes.io/docs/concepts/cluster-administration/addons/*



*You can now join any number of machines by running the following on each node*

*as root:*



  *kubeadm join 192.168.0.130:6443 --token gzyfvx.kt9bt4tbt9rexbo8 --discovery-token-ca-cert-hash sha256:8d7124791b48c73a5d232759edfa84a9ab9dceeb738db08cfd066e92d0fd7549*





*其中*

​    *kubeadm join 10.211.55.6:6443 --token 63nuhu.quu72c0hl95hc82m --discovery-token-ca-cert-hash sha256:3971ae49e7e5884bf191851096e39d8e28c0b77718bb2a413638057da66ed30a*

*是后续节点加入集群的启动命令，由于设置了**--token-ttl 0**，所以该命令永久有效，需保存好，kubeadm token list命令可以输出token，但不能输出完整命令，需要做hash转换。*



***注意⚠️****：集群启动后要获取集群的使用权限，否则在master节点执行kubectl get nodes命令，会反馈**localhost:8080* *connection* *refused**,获取权限方法如下：*



| Root用户：   | **export** **KUBECONFIG****=/etc/kubernetes/admin.conf**     |
| ------------ | ------------------------------------------------------------ |
| 非Root用户： | **mkdir** **-p** **$HOME****/.kube****sudo** **cp** **-i** **/etc/kubernetes/admin.conf** **$HOME****/.kube/config****sudo** **chown** **$(id** **-u****):$(id** **-g****)** **$HOME****/.kube/config** |



***三.安装网络插件Pod:***

*在成功启动Master节点后，在添加node节点之前，需要先安装网络管理插件，kubernetes可供选择的网络插件有很多，*

*如**Calico，Canal，flannel，Kube-router,Romana,Weave Net* 

*各种安装教程可以参考官方文档，**点击这里*

*本文选择flannel作为网络插件：*

​    *vim /etc/sysctl.conf，添加以下内容*

​    *net.ipv4.ip_forward=1*

​    *net.bridge.bridge-nf-call-iptables=1*

​    *net.bridge.bridge-nf-call-ip6tables=1*

​    *修改后，及时生效*

​    *sysctl -p*

*执行安装：*

  ***kubectl apply -f*** *https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml*

*安装完成后，执行：*

​    ***kubectl get pods --all-namespaces***

*查看Pod的启动状态，一旦kube-dns Pod的启动状态为UP或者Running，集群就可以开始添加节点了。*



***四.添加Node节点：***

*启动Node节点加入集群只需启动kubelet，然后执行之前保存的命令：*

​    *systemctl start kubelet*

​    *kubeadm join 10.211.55.6:6443 --token 63nuhu.quu72c0hl95hc82m --discovery-token-ca-cert-hash sha256:3971ae49e7e5884bf191851096e39d8e28c0b77718bb2a413638057da66ed30a*

*节点成功加入集群。*



*在主节点执行**kubectl get nodes**，验证集群状态，显示如下：*

*[root@master ~]# kubectl get nodes*

*NAME      STATUS    ROLES     AGE       VERSION*

*master    Ready     master    7h        v1.10.0*

*node1     Ready     <none>    6h        v1.10.0*

*node2     Ready     <none>    2h        v1.10.0*

*node3     Ready     <none>    4h        v1.10.0*

*Kubenetes v1.10.0 集群构建完成！*



***五.Kubernetes-Dashboard（WebUI）的安装：***

*和网络插件的用法一样，dashboard也是一个容器应用，同样执行安装yaml：*

​    ***kubectl create -f*** *https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml*

*可以参考官方文档，**点击这里**。*

*安装完成后，执行：*

   ***kubectl get pods --all-namespaces***

*查看Pod的启动状态，kubernetes-dashboard启动完成后，执行：*

​    *kubectl proxy --address=10.211.55.6 --accept-hosts='^\*$'*

*基本参数是address为master节点的IP，access-host如果不填，打开web页面会返回：*

​    *<h3>**unauthorized<h3>*

*启动后控制台输出：*

​    *Starting to serve on 10.211.55.6:8001*

*打开WebUI：*

​    *http://10.211.55.6:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default*

*见如下页面：*

![image2](https://user-images.githubusercontent.com/30173222/57582794-b099e600-74fb-11e9-8443-4c0c6e2f0cb7.png)



*这是需要用一个可用的ClusterRole进行登录，该账户需要有相关的集群操作权限，如果跳过，则是用默认的系统角色kubernetes-dashboard（该角色在创建该容器时生成），初始状态下该角色没有任何权限，需要在系统中进行配置，角色绑定：*

*在主节点上任意位置创建一个文件xxx.yaml，名字随意：*

​    *vim ClusterRoleBinding.yaml*

​    *编辑文件：*

​    *kind: ClusterRoleBinding*

​    *apiVersion: rbac.authorization.k8s.io/v1beta1*

​    *metadata:*

​      *name: kubernetes-dashboard*

​    *subjects:*

​      *- kind: ServiceAccount*

​        *name: kubernetes-dashboard*

​        *namespace: kube-system*

​    *roleRef:*

​      *kind: ClusterRole*

​      *name: cluster-admin*

​      *apiGroup: rbac.authorization.k8s.io*



*保存，退出，执行该文件：*

​    *kubectl create -f ClusterRoleBinding.yaml*

*再次打开WebUI，成功显示集群信息：*

![image3](https://user-images.githubusercontent.com/30173222/57582814-f0f96400-74fb-11e9-824a-c3cc02605f91.png)



*注意⚠️**：给kubernetes-dashboard角色赋予cluster-admin权限仅供测试使用，本身这种方式并不安全，建议新建一个系统角色，分配有限的集群操作权限，方法如下：*

*新建一个yaml文件，写入：*

*kind: ClusterRole* *#创建集群角色*

*apiVersion: rbac.authorization.k8s.io/v1beta1*

*metadata:*

  *name: dashboard*  *#角色名称*

*rules:*

*- apiGroups: [**"\*"]*

  *resources: ["***”]* *#所有资源*

  *verbs: ["get"**,* *"watch"**,* *"list"**,* *"create"**,**"proxy"**,**"update**”]* *#赋予获取，监听，列表，创建，代理，更新的权限*

*- apiGroups: [**"\*"]*

  *resources: ["pods**”]* *#容器资源单独配置（在所有资源配置的基础上）*

  *verbs: ["delete**”]* *#提供删除权限*

*---*

*apiVersion: v1*

*kind: ServiceAccount*  *#创建ServiceAccount*

*metadata:*

  *name: dashboard*

  *namespace: kube-system*

*---*

*kind: ClusterRoleBinding*

*apiVersion: rbac.authorization.k8s.io/v1beta1*

*metadata:*

  *name: dashboard**-**extended*

*subjects:*

  *-**kind: ServiceAccount*

​    *name: dashboard*

​    *namespace:* *kube-system*

*roleRef:*

  *kind: ClusterRole*

  *name:**dashboard*   *#填写cluster-admin代表开放全部权限*

  *apiGroup: rbac.authorization.k8s.io*



*执行该文件，查看角色是否生成：*

​    *kubectl get serviceaccount --all-namespaces*

*查询该账户的密钥名：*

​        *kubectl get secret  -n kube-system*

*根据密钥名找到token：*

​        *kubectl discribe secret dashboard-token-wd9rz -n kube-system*

*输出一段信息：*



*将此token用于登陆WebUI即可。*

![image4](https://user-images.githubusercontent.com/30173222/57582821-0e2e3280-74fc-11e9-9d1b-16812129cdf8.png)

*以上便是Kubeadm安装K8S v1.10.0版本的全记录，本文用于总结与梳理，参考于官方文档，如有错漏，望予指正。*



## JDK Maven setup env on Ubuntu

[jdk maven env setup on Ubuntu]({{%relref "jdk_maven_env_ubuntu.md"%}})