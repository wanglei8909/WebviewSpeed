# WebviewSpeed
h5加载速度优化方案
加载过程：初始化 webview -> 请求页面 -> 下载数据 -> 解析HTML -> 请求 js/css 资源 -> dom 渲染 -> 解析 JS 执行 -> JS 请求数据 -> 解析渲染 -> 下载渲染图片
1.缓存
	1.拦截webview的每个请求
		1.每次下载数据 加载到内存中
		2.设置cachePolicy为每次重新请求不走webview自己的缓存
		3.注册拦截协议
		4.拦截每个请求 返回内存中的数据
		4.UIWebView好实现  WKWebView没有官方的API支持
	2.我们采用整个离线包的预下载缓存形式 资源包预下载 （直接到webview的缓存里）
		1.每次启动后合适时机去预加载离线包更新缓存
		2.disk cache and memory cache
		3.让webview提前加载资源和执行JS
		
2.webview缓存池 提前创建webview
	1.首次预加载：在一个进程内首次初始化 webview 与第二次初始化不同，首次会比第二次慢很多。原因预计是 webview 首次初始化后，即使 webview 已经释放，但一些多 webview 共用的全局服务或资源对象仍没有释放，第二次初始化时不需要再生成这些对象从而变快。我们可以在 APP 启动时预先初始化一个 webview 然后释放，这样等用户真正走到 H5 模块去加载 webview时就变快了
	2.webview 池：可以用两个或多个 webview 重复使用，而不是每次打开 H5 都新建 webview。要解决页面跳转时清空上一个页面 load一个空字符串


优化效果 iphoneX :0.18s   6s:0.3s   5s:0.6s
