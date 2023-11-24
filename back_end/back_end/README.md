# 北航二手书网站

任务：简易电子商务系统

设计文档

部署和使用手册

## 部署

**版本依赖**

```ruby
ruby "3.2.2"
gem "rails", "~> 7.0.8"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "importmap-rails"
gem "sprockets-rails"
gem 'stimulus-rails'
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
```

**运行**

直接通过 `rails s` 启动，数据库为 `SQLite3` 本地数据库

管理员登录（用于测试）

```json
{
	"phone": "13812345678",
	"user_name": "admin",
	"password": "adminadmin"
}
```

## 系统设计

### 主体架构

**技术层面**

本项目采用的是**前后端分离**的方式

- 前端：Vite + Vue 提供组件以及视图渲染
- 后端：Rails 提供访问数据库的接口
- 利用 `json` 格式数据通过 `http` 协议进行前后端的交互。从前端发来的 http 请求中，根据 Route 将请求分发给不同 Controller 中，由 Controller 来与数据库进行

前后端整合：利用 Rails7 推荐的 Asset Pipeline + ImportMap gem 包处理 js 文件 以及 Sprockets 处理 css 文件

**需求层面**

鉴于二手书市场中，卖家与买家更多都是个体用户，故不区分商家与买家，而是所有用户都能够独立购买商品或售出商品

除此以外，管理员可对已在书架上售卖的书籍进行一系列操作，也可对订单进行一系列操作

### 实现功能

**用户模块**

- 注册
- 登录
- 注销
- 获取用户个人信息
- 更改密码、用户名、邮寄地址

**二手书商品模块**

- 查看所有商品
- 添加商品
- 获取商品信息
- 获取卖家商品列表
- 更改库存、价格、商品地址
- 将商品添加到购物车
- 删除商品

**购物车模块**

- 查看当前用户的购物车
- 将购物车中的商品全部添加进订单

**订单模块**

- 查看当前用户的订单
- 查看所有平台订单（admin only）
- 删除订单（admin only）
