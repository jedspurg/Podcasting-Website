class WaveFileGeneratorWorker
  include Sidekiq::Worker

  def perform(episode)
    episode.generate_waveform_files
  end
end
