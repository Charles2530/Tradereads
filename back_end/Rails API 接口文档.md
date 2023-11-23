# Rails API 接口文档

Status: In progress
Project: 后端 Rails (https://www.notion.so/Rails-746bb4dd7b844a3386eea4aac30b159c?pvs=21)

数据格式均为 `json` 格式，商品就是书

**测试用户 1**

`id` ：1

`phone` ：”123123”

`right` ：1

`password` ：”123123123”

`user_name` ：”admin”

`buy_address` ：”buaa”

`gender` ：”male”

`pay_type` ：”Alipay”

**测试用户 2**

`id` ：8

`phone` ：”13812345678”

`right` ：0

`password` ：”abcdefg”

`user_name` ：”abcdefg”

`buy_address` ：nil

`gender` ：”male”

`pay_type` ：”Alipay”

## 用户模块

### 注册

请求路径： `/api/register` 

请求方法： `POST`

请求数据格式：

- `phone` ：字符串格式，表示用户设置的手机号
- `user_name` ：字符串格式，表示用户设置的用户名
- `gender` ：字符串格式，表示用户设置的性别
- `password` ：字符串格式，表示用户设置的密码

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"This user existed."` ——用户已存在
    - `"Register failed."` ——注册失败（可能是数据不合规范）
    - `"Register succeeded."` ——注册成功

### 登录

请求路径： `/api/login` 

请求方法： `POST`

请求数据格式：

- `phone` : 字符串格式，表示用户登录使用的手机号
- `password` ：字符串格式，表示用户登录使用的密码

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Please enter appropriate information."` ——输入的手机号或密码为空
    - `"Password is wrong."` ——密码错误
    - `"This user is not existed."` ——用户不存在
    - `"Login succeeded."` ——登录成功
- `data` ：额外输出的信息
    - `user_id` ：表示用户名在数据库中的 id
    - `user_name` ：字符串格式，表示用户名
    - `right` ：整数格式（0 或 1），0 表示普通用户，1 表示管理员

### 注销

请求路径： `/api/logout` 

请求方法： `GET`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串

### 获取用户个人信息

请求路径： `/api/users/<user_id>` 

请求方法： `GET`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Show failed."` ——获取信息失败（可能是 id 不存在）
    - `"Show succeeded."` ——获取成功
- `data` ：额外输出的信息
    - `phone` ：字符串格式，表示用户电话
    - `user_name` ：字符串格式，表示用户名
    - `buy_address` ：字符串格式，表示用户地址
    - `gender` ：字符串格式，表示用户性别
    - `pay_type` ：字符串格式，表示支付方式

### 更改密码

请求路径： `/api/users/<user_id>/modify_password`   

请求方法： `POST`

请求数据格式：

- `old_password` ：字符串格式，表示旧密码
- `new_address` ：字符串格式，表示新密码

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Old password was incorrect."` ——旧密码错误
    - `"Modify password failed."` ——密码更改失败（可能是新密码不合规范）
    - `"Modify password succeeded."` ——更改成功

### 更改用户名

请求路径： `/api/users/<user_id>/modify_username`   

请求方法： `POST`

请求数据格式：

- `new_username` ：字符串格式，表示新用户名

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Modify username succeeded."` ——更改用户名成功
    - `"Modify username failed."` ——更改用户名失败

### 更改购买地址

请求路径： `/api/users/<user_id>/modify_address`   

请求方法： `POST`

请求数据格式：

- `new_address` ：字符串格式，表示新购买地址

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Modify buy address succeeded."` ——更改地址成功
    - `"Modify buy address failed."` ——更改地址失败

## 商品模块

### 添加商品

请求路径： `/api/products`   

请求方法： `POST`

请求数据格式：

- `price` ：浮点数，商品价格
- `sell_address` ：字符串，发货地址
- `store` ：整型，库存量
- `product_name` ：字符串，商品名
- `product_image` ：字符串，商品照片地址
- `product_press` ：字符串，商品出版社
- `product_type` ：字符串，书类

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Create product succeeded."` ——添加成功
    - `"Create product failed."` ——添加失败
- `data` ：额外输出信息
    - `product_id` ：数字，商品 id
    - `state` ：字符串，库存状态

### 获取商品信息

请求路径： `/api/products/<product_id>`   

请求方法： `GET`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Show product succeeded."` ——获取成功
    - `"Show product failed."` ——获取失败
- `data` ：额外输出信息
    - `product_name` ：字符串格式，商品名
    - `product_press` ：字符串格式，商品出版社
    - `product_price` ：浮点数，商品价格
    - `product_state` ：`Available` 有货，`StockOut` 缺货
    - `seller_name` ：字符串格式，卖家用户名
    - `seller_phone` ：字符串格式，卖家联系电话

### 获取卖家商品列表

请求路径： `/api/users/<user_id>/show_product_list`   

请求方法： `GET`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Show product list succeeded."` ——获取成功
    - `"Show product list failed."` ——获取失败
- `data` ：额外输出信息
    - `products` ：数组类型，卖家的商品
        - `product_name` ：字符串，商品名
        - `product_image` ：字符串，商品图片地址
        - `price` ：浮点数，商品价格

### 更改库存

请求路径： `/api/products/<product_id>/modify_store`   

请求方法： `POST`

请求数据格式：

- `new_store` ：新库存

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Only the seller of the product can modify."` ——非卖家不可修改
    - `"Modify store failed."` ——更改失败（可能是数据不合规格）
    - `"Modify store succeeded."` ——更改成功

### 更改价格

请求路径： `/api/products/<product_id>/modify_price`   

请求方法： `POST`

请求数据格式：

- `new_price` ：新价格

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Only the seller of the product can modify."` ——非卖家不可修改
    - `"Modify price failed."` ——更改失败（可能是数据不合规格）
    - `"Modify price succeeded."` ——更改成功

### 更改商品地址

请求路径： `/api/products/<product_id>/modify_sell_address`   

请求方法： `POST`

请求数据格式：

- `new_sell_address` ：新地址

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Only the seller of the product can modify."` ——非卖家不可修改
    - `"Modify sell address failed."` ——更改失败（可能是数据不合规格）
    - `"Modify sell address succeeded."` ——更改成功

### 将商品添加到购物车

请求路径： `/api/products/<product_id>/add_product_to_cart`   

请求方法： `POST`

请求数据格式：

- `count` ：需要添加购买商品的数量

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Only the seller of the product can modify."` ——非卖家不可修改
    - `"Modify sell address failed."` ——更改失败（可能是数据不合规格）
    - `"Modify sell address succeeded."` ——更改成功

### 删除商品

请求路径： `/api/products/<product_id>`   

请求方法： `DELETE`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Failed."`
    - `"Succeed."`

## 购物车模块

### 查看当前用户的购物车

请求路径： `/api/show_cart`   

请求方法： `GET`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
- `data` ：额外输出信息
    - `total_price` ：浮点数形式，购物车内总金额
    - `products` ：数组形式
        - `product_id` ：整数形式，商品 id
        - `product_name` ：字符串形式，商品名字
        - `seller_name` ：字符串形式，卖家名字
        - `product_number` ：整数形式，加入购物车的该商品的数量

### 查看其他用户的购物车（admin only）

### 将购物车中的商品全部添加进订单

请求路径： `/api/carts_to_orders`

请求方法： `GET`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Failed."`
    - `"Succeed."`

## 订单模块

### 查看当前用户的订单

请求路径： `/api/show_current_orders`

请求方法： `GET`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
- `data` ：额外输出信息
    - `orders` ：数组形式
        - `order_id` ：该订单的 id
        - `total_price` ：该订单的总金额
        - `items` ：数组形式，表示订单项
            - `product_image` ：字符串，商品照片地址
            - `product_name` ：字符串，商品名字
            - `sell_address` ：字符串，发货地址
            - `buy_num` ：正整数，当前用户购买该商品的数量
            - `product_price` ：浮点数，单种商品的总价格（数目*单价）
            - `state` ：字符串，该订单中该商品的状态
                - `"toPay"` ：待支付
                - `"toDeliver"` ：待发货
                - `"toTake"` ：待收货
                - `"completed"` ：已完成

### 查看所有平台订单（admin only）

请求路径： `/api/orders`

请求方法： `GET`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Unauthorized."` ：该用户不是管理员
    - `"Succeed."`
- `data` ：额外输出信息
    - `orders` ：数组形式
        - `order_id` ：该订单的 id
        - `buyer_id` ：该订单的买家 id
        - `total_price` ：该订单的总金额
        - `items` ：数组形式，表示订单项
            - `product_image` ：字符串，商品照片地址
            - `product_name` ：字符串，商品名字
            - `sell_address` ：字符串，发货地址
            - `buy_num` ：正整数，当前用户购买该商品的数量
            - `product_price` ：浮点数，单种商品的总价格（数目*单价）
            - `state` ：字符串，该订单中该商品的状态
                - `"toPay"` ：待支付
                - `"toDeliver"` ：待发货
                - `"toTake"` ：待收货
                - `"completed"` ：已完成

### 删除订单（admin only）

请求路径： `/api/orders/<order_id>`  

请求方法： `DELETE`

请求数据格式：无需请求数据

返回数据格式：

- `success` ： `true` 或 `false`
- `message` ：错误信息字符串
    - `"Unauthorized."` ：非管理员不可操作
    - `"Failed."`
    - `"Succeed."`