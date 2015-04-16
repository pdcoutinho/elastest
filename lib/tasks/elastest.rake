namespace :elastest do
  desc "TODO"
  task drop_index: :environment do
    start_time = Time.now
    puts "Dropping index..."
    Article.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil
    end_time = Time.now
    puts "Dropped index in #{end_time - start_time} milliseconds."
  end

  desc "TODO"
  task create_index: :environment do
    start_time = Time.now
    puts "Creating index..."
    Article.import
    end_time = Time.now
    puts "Indexed #{Article.all.count} articles in #{end_time - start_time} milliseconds."
  end

end
