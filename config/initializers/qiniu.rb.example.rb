::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = "ak"
  config.qiniu_secret_key    = 'sk'
  config.qiniu_bucket        = "bucket name"
  config.qiniu_bucket_domain = "domain"
  config.qiniu_bucket_private= false
  #config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"

  #config.qiniu_up_host       = 'http://up.qiniug.com' #七牛上传海外服务器,国内使用可以不要这行配置
end