# 北航二手书网站

任务：简易电子商务系统

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
	"phone": "13612345678",
	"user_name": "admin",
	"password": "adminadmin"
}
```

普通用户，可自行注册，默认无管理权限

**整合**

先将 vue 打包

```shell
npm run build
```

然后会得到 `dist` 文件夹，将文件夹 `dist/assets` 分类— `javascipts`, `stylesheets`(, `images`) 然后将 `dist` 中的所有文件放在 Ruby 项目的 `app/assets` 文件夹下，剩下的不在原 `dist/assets` 里的以及 `fonts` 放在 Ruby 的 `public` 中

添加依赖

```ruby
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
```

安装 importmap

```shell
rails importmap:install
```

得到 `app/javascript/application.js`, `vendor/javascript/.keep`,  `config/importmap.rb`

安装 sprockets-rails

```shell
gem install sprockets
```

新建 `app/assets/config/manifest.js` ，并填入默认 link

```js
//= link_tree ../images
//= link_directory ../javascripts .js
//= link_directory ../stylesheets .css
```

安装 stimulus-rails

```shell
rails stimulus:install
```

安装 turbo-rails

```
rails turbo:install:redis
```

安装 cssbundling-rails（因为使用了 tailwind CSS）

```shell
bundle add cssbundling-rails
rails css:install:tailwind
```

## 系统设计

### 主体架构

本项目采用的是**前后端分离**的方式

- 前端：Vite + Vue 提供组件以及视图渲染
- 后端：Ruby on Rails 提供访问数据库的接口
- 利用 `json` 格式数据通过 `http` 协议进行前后端的交互。从前端发来的 http 请求中，根据 Route 将请求分发给不同 Controller 中，由 Controller 来与数据库进行数据存取，最后再通过 `render` 将包含信息的 `json` 数据再发送回前端

前后端整合：利用 Rails7 推荐的 Asset Pipeline + ImportMap gem 包处理 js 文件 以及 Sprockets 处理 css 文件

### 实现功能

鉴于二手书市场中，卖家与买家更多都是个体用户，故不区分商家与买家，而是所有用户都能够独立购买商品或售出商品

除此以外，管理员可对已在书架上售卖的书籍进行一系列操作，也可对订单进行一系列操作

整体涉及的实体有用户，商品，订单，订单项，购物车

**用户模块**

- 用户可进行注册、登录和登出账号的操作
- 由于用户本身既是卖家也是买家，故可通过链接获取用户个人信息，如电话、用户名等
- 用户可更改密码、用户名、邮寄地址

**二手书商品模块**

- 所有用户均可查看所有商品，并获取商品信息，如价格，发货地址，销售状态，商品名称，商品图片，商品出版社，商品类型等
- 所有用户均可添加商品，也就是可以卖出商品
- 用户可以获取自家卖出的商品列表，以便管理库存、发货地址及价格，也可以删除自家卖出的商品
- 管理员也可以直接删除商品

**购物车模块**

- 用户可以将商品添加到购物车

- 用户查看自己的购物车信息，如总金额，商品类型，商品个数
- 通过点击 button，可将购物车中的商品全部添加进订单，购物车清空的操作

**订单模块**

- 用户可以查看自己已经下单的订单信息，比如订单状态（待付款，待发货，待取货，已完成），订单总金额，订单下单时间
- 管理员查看平台所有的订单，并进行相应的统计操作，或者删除订单操作

