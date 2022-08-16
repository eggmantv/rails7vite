# rails 7

## Webpacker

Webpacker、UJS 和 Turbolinks 被 Hotwire 和 Stimulus 取代。

这可以实现快速的首次加载页面，在服务器上保持模板渲染，并允许使用任何编程语言提供更简单、更高效的开发体验，而不会牺牲与传统的单页应用程序

## Rails 原生加密

在 Rails 7.0 之前，要对 ActiveRecord 模型的属性添加加密，我们必须使用第三方 gem，例如 lockbox，它可以达到目的，但代价是额外的依赖。

Rails 7.0 在模型级别为属性添加了加密。默认情况下，它支持使用非确定性 AES-GCM 密码对序列化属性类型进行加密。

要使用此功能，我们必须在环境文件中设置 key_derivation_salt、primary_key 和 deterministic_key 变量。这些密钥可以通过运行 bin/rails db:encryption:init 生成。

## ActiveModel::API

## 并行查询加载

当你有一个控制器和 action 需要加载两个不相关的查询时，现在你可以通过 Relation#load_async 来进行并发查询了。例如，你有三个复杂的查询，每个要花费 100ms 时间，以前就必须用 300ms 的时间。现在就可以进行并行查询，总共只需要 100ms 即可。

config.active_record.async_query_executor = :global_thread_pool
global_thread_pool 默认：4

```javascript
  def index
    @users = User.all.load_async
    @home = Home.all.load_async
    @device = Device.all.load_async
  end


```

## 永远重试 ActiveJobs

retry_on AlwaysRetryException, attempts: :unlimited

attempts: 5 默认值为 5


## Spring

Spring 不在默认启动
