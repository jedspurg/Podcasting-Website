class WaveFileGeneratorWorker
  include Sidekiq::Worker

  def perform(episode_id)
    episode = Episode.find_by(id: episode_id)
    episode.generate_waveform_files
  end
end
