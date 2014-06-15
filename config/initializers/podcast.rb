PODCAST_SETTINGS = YAML::load(open("#{Rails.root}/config/podcast_settings.yml")).symbolize_keys rescue {}
