namespace :elastest do
  desc "Drops the model index"
  task :drop_index, [:index_name] => :environment do |t, model_name|
    _model_name = model_name[:index_name].capitalize.constantize
    start_time = Time.now
    puts "Dropping index for #{_model_name}..."
    _model_name.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil
    end_time = Time.now
    puts "Dropped index for #{_model_name} in #{end_time - start_time} milliseconds."
  end

  desc "Creates the model index"
  task :create_index, [:index_name] => :environment do |t, model_name|
    _model_name = model_name[:index_name].capitalize.constantize
    start_time = Time.now
    puts "Creating index for #{_model_name}..."
    _model_name.import
    end_time = Time.now
    puts "Indexed #{_model_name.all.count} articles in #{end_time - start_time} milliseconds."
  end

  desc "Creates the model indices"
  task :create_indices, [:index_name] => :environment do |t, model_name|
    _model_name = model_name[:index_name].capitalize.constantize
    start_time = Time.now
    puts "Creating index for #{_model_name}..."
    _model_name.__elasticsearch__.client.indices.create \
      index: _model_name.index_name,
      body: { settings: _model_name.settings.to_hash, mappings: _model_name.mappings.to_hash }
    end_time = Time.now
    puts "Indexed #{_model_name.all.count} #{_model_name} in #{end_time - start_time} milliseconds."
  end
end
