#  设计思路


>>>>  面试官请看这里

 
## 架构和三方库

1. 架构：采用MVVM 编写，VM负责主要的逻辑处理
2. 三方库：
    * 网络: Alomofire
    * Layout: SnapKit
    * 响应式编程：RxSwift
    * 图片库：Kingfisher

## 思路

1. 模仿Moya 以协议的方式简单封装了一下网络库 让输出以流的形式传输
2. 对Router Coordinatro做了一些封装
3. 主体业务采用了MVVM的形式，以Driver作为input output 利用rxcocoa绑定了流
4. 对Storyboard codable color refresh 这些做了一些简单封装


Tips: 由于对rx测试代码不熟悉 所以没有贸然写测试代码 请见谅～
