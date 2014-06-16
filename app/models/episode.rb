class Episode < ActiveRecord::Base
  require 'taglib'

  validates :title, :author, :subtitle, :summary, :pub_date, presence: true
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_attached_file :audio
  validates_attachment_content_type :audio, :content_type => /\Aaudio\/.*\Z/

  after_save :generate_waveform_files

  def image_url
    if image.present?
      "#{Rails.application.routes.url_helpers.root_url.chomp('/')}#{image.url(:original, false)}"
    end
  end

  def generate_waveform_files
    %x[ ffmpeg -i "#{audio.path}" -f wav "#{Rails.root}/public/assets/wav_episode_#{id}.wav" ]
    Waveform.generate("#{Rails.root}/public/assets/wav_episode_#{id}.wav", waveform_file_path, :color => "#333333", :background_color => "#FFFFFF")
    Waveform.generate("#{Rails.root}/public/assets/wav_episode_#{id}.wav", waveform_scrub_file_path, :color => "#a46605", :background_color => :transparent)
  end

  def waveform_file_path
    "#{Rails.root}/public/assets/wav_episode_#{id}.png"
  end

  def waveform_scrub_file_path
    "#{Rails.root}/public/assets/wav_episode_#{id}_scrub.png"
  end

  def waveform_file_url
    "#{Rails.application.routes.url_helpers.root_url.chomp('/')}/assets/wav_episode_#{id}.png"
  end

  def waveform_scrub_file_url
    "#{Rails.application.routes.url_helpers.root_url.chomp('/')}/assets/wav_episode_#{id}_scrub.png"
  end

  def file_url
    if audio.present?
      "#{Rails.application.routes.url_helpers.root_url.chomp('/')}#{audio.url(:original, false)}"
    end
  end

  def file_length
    audio_file_size
  end

  def file_type
    audio_content_type
  end

  def duration
    TagLib::FileRef.open(audio.path) do |fileref|
      unless fileref.null?
        properties = fileref.audio_properties
        properties.length  #=> 335 (song length in seconds)
      end
    end
  end

end
