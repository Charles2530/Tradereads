# Tradereads
## 前端实现
### 前端体系结构

前端使用 vite + vue3 + javascript作为基本框架进行web开发，采用了响应式布局，良好适配不同分辨率的屏幕，具有美观性；采用了vue的单文件组件格式，使用template进行基本布局，JavaScript为网页处理动态事件，使用tailwind css和element plus美化网页布局,实现网页布局和样式的一致性；基于VueRouter实现了前端路由跳转，无需每次从后端获取html页面，只需要通过api从后端获取少量数据，减少了IO开销，提高了网页速度;利用Pinia插件来管理全局状态，以便在整个应用程序中共享数据和状态; 集成ECharts库，以便在应用程序中创建各种图表和数据可视化，以展示信息和趋势。

在前后端交互上，项目采用前后端分离的写法，前端通过axios根据与后端约定好的api进行交互，发送和得到后端的数据并在客户端渲染，降低了前后端的耦合度。

在项目构建上，项目采用了vite来构建vue3项目。并且通过划分文件夹使得前端项目文件结构清晰，其中

- api文件夹存储进行前后端交互的api方法的JavaScript文件

- assets文件夹存储前端需要的静态资源，如css，img和font

- components文件夹存储可复用的vue组件
- locates用于国际化配置语言相关文件

- router文件夹存放vue项目的路由文件

- store文件夹存放保存的Pinia插件的文件，类似全局变量
- utils文件夹存放了一些全局的效果配置，如点击鼠标爱心和axios等

- views文件夹存放基本页面的vue文件

基于上述功能，前端实现了一个Tradereads(北航二手书交易市场）。

### **前端实现环境**

- 相关依赖

vite: 4.5.0

vue: 3.3.4

tailwindcss: 3.3.5

element-plus: 2.4.3

@vue/cli: 5.0.8

@element-plus/icons-vue: 2.3.1

@vueuse/core: 10.5.0

axios: 1.6.0

echarts: 5.4.3

pinia: 2.1.7

postcss: 8.4.31

vue-i18n: 9.8.0

vue-router: 4.2.5

- 启动命令:

```shell
# 本地运行
npm run dev
# 云端运行
npm run build
npm run preview
```

## 后端实现
**后端: Ruby on Rails**

Ruby on Rails 负责提供访问数据库的接口

利用 `json` 格式数据通过 `http` 协议进行前后端的交互。从前端发来的 `http` 请求中，根据 Route 将请求分发给不同 Controller 中，由 Controller 来与数据库进行数据存取，最后再通过 `render` 将包含信息的 `json` 数据再发送回前端

Ruby on Rails 依赖 `Gemfile`

```ruby
ruby "3.2.2"
gem "rails", "~> 7.0.8"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rest-client", "~> 2.1.0"
gem 'ffi', '~> 1.16', '>= 1.16.3'
gem 'rack-cors'
```

启动后端指令

```shell
rails s
```
