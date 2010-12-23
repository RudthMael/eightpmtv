namespace :app do
  desc "Search for missing unindexed foreign keys"
  task :missing_fk_index => :environment do |t, args|
    c = ActiveRecord::Base.connection
    c.tables.collect do |t|  
      columns = c.columns(t).collect(&:name).select {|x| x.ends_with?("_id" || x.ends_with("_type"))}
      indexed_columns = c.indexes(t).collect(&:columns).flatten.uniq
      unindexed = columns - indexed_columns
      unless unindexed.empty?
        puts "#{t}: #{unindexed.join(", ")}"
      end
    end
  end
end