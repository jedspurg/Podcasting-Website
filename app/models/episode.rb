class Episode < ActiveRecord::Base
  require 'taglib'

  validates :title, :author, :subtitle, :summary, :pub_date, presence: true
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_attached_file :audio
  validates_attachment_content_type :audio, :content_type => /\Aaudio\/.*\Z/

  def image_url
    if image.present?
      "#{Rails.application.routes.url_helpers.root_url.chomp('/')}#{image.url(:original, false)}"
    end
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
