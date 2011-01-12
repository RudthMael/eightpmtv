require 'rake'
require 'aws/s3'
require 'tasks/backup_helper'

BACKUP_BUCKET = YAML::load(IO.read(File.join(Rails.root, "config", "amazon_s3.yml")))[Rails.env]['backup']
prefix        = Rails.env

namespace :db do
  # usage: heroku rake db:restore --app harilo
  # usage: heroku rake db:restore RAILS_ENV=production #to restore to latest backup
  # usage: heroku rake db:restore filename=production_2010-07-20_23-35-46.tar.gz.tar.gz
  desc "Restores db from s3 backup file"
  task :restore => [:environment, :reset] do    
    filename = ENV['filename'] || s3_latest(BACKUP_BUCKET, prefix)

    puts "Retrieving #{filename}..."
    s3_download(BACKUP_BUCKET, filename)

    puts "Decompressing backup..."
    `tar -xzf tmp/#{filename}`

    puts "Restoring database..."
    pg_restore(filename.gsub('.tar.gz', '.pgdump'))

    puts "Cleaning up..."
    `rm tmp/#{filename.gsub('.tar.gz', '')}*`
  end

  # usage: rake db:backup RAILS_ENV=production
  desc "Backs up db and uploads to s3"
  task :backup => :environment do  
    puts "Back up started @ #{Time.now}"
    
    timestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    filename = "#{prefix}_#{timestamp}"
    
    puts "Creating postgres dump..."
    pg_dump(filename)

    puts "Compressing backup..."
    `tar -czf tmp/#{filename}.tar.gz tmp/#{filename}*`

    puts "Uploading #{filename}.tar.gz to S3..."
    s3_upload(BACKUP_BUCKET, "tmp/#{filename}.tar.gz")
    
    puts "Cleaning up"
    `rm tmp/#{filename}*`
  end
end