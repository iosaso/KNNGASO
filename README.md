# ASO

>>此项目主要为，IOS端AppStore进行刷榜操作


   
## 项目技术介绍

1. 采用Tweak进行开发
2. 增加了部分私有库，需要自己根据我的makefile中引入的私有库。
3. 打包了PTFTouch的开源触碰（如果有兴趣可以fork）
4. 包含了OC的一些运行时内容
5. html脚本的注入


 
  
  
# 项目结构

|文件名|描述|功能|
|---|-----|------|
|ASO|AppStore Search optimize 的相关逻辑代码|包含注入点 ，改吗，过验证码，卸载，模拟点击 等|
|layout|一些常用的图标文件|用于美化插件|
|lib|插件需要的一些依赖，我已经将其打成支持各个手机arm的lib||
|Makefile|项目的编译管理||
|Tweak.xm|注入点的声明||
|NGASO.plist|当前此项目的注入程序的进程||

  -----
  
  
 
# KNNGASO
/Users/devzkn/code/knaso/ASO

# 用rm递归递归删除子目录下所有._*后缀文件

```
find . -name "._*"  | xargs rm -f
```
