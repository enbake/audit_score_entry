CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => AppConfig.AWS_ACCESS_KEY_ID,
    :aws_secret_access_key  => AppConfig.AWS_SECRET_ACCESS_KEY
  }
  config.fog_directory  = AppConfig.AWS_BUCKET                     # required
  config.fog_public     = true                                   # optional, defaults to true
end