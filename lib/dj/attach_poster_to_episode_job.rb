class AttachPosterToEpisodeJob < Struct.new(:episode_id, :poster_url)
  def perform
    episode = Episode.find(episode_id)
    episode.poster = RemoteFile.new("http://thetvdb.com/banners/#{poster_url}")
    episode.save
    
    Delayed::Job.enqueue(AttachImageToEpisodeActivitiesJob.new(episode_id), :priority => 4)
  end
end