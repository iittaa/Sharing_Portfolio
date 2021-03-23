CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog-aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA3G5UINZSLY5MK4WZ',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'sharing-portfolio-photo'
    config.cache_storage = :fog
  else
    config.storage = :file
  end
end
