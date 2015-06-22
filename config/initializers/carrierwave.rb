CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV["aws_access_key_rmx"],
    :aws_secret_access_key  => ENV["aws_access_token_rmx"],
    :region                 => 'eu-central-1'
  }
  config.fog_directory  = ENV["aws_bucket_rmx"]
end
