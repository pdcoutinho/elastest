namespace :elastest do
  desc "Drops the model index"
  task :drop_index, [:model_name] => :environment do |t, model_name|
    _model_name = model_name[:model_name].capitalize.constantize
    start_time = Time.now
    puts "Dropping index for #{_model_name}..."
    _model_name.__elasticsearch__.client.indices.delete index: _model_name.index_name rescue nil
    end_time = Time.now
    puts "Dropped index for #{_model_name} in #{end_time - start_time} milliseconds."
  end

  desc "Creates the model indices"
  task :create_indices, [:model_name] => :environment do |t, model_name|
    _model_name = model_name[:model_name].capitalize.constantize
    start_time = Time.now
    puts "Creating indices for #{_model_name}..."
    _model_name.__elasticsearch__.client.indices.create \
      index: _model_name.index_name,
      body: { settings: _model_name.settings.to_hash, mappings: _model_name.mappings.to_hash }
    end_time = Time.now
    puts "Created indices for #{_model_name} in #{end_time - start_time} milliseconds."
  end

  desc "Creates the model index"
  task :create_index, [:model_name] => :environment do |t, model_name|
    _model_name = model_name[:model_name].capitalize.constantize
    start_time = Time.now
    puts "Creating index for #{_model_name.to_s.pluralize}..."
    _model_name.import
    end_time = Time.now
    puts "Indexed #{_model_name.all.count} #{_model_name.to_s.pluralize} in #{end_time - start_time} milliseconds."
  end

  desc "Runs all tasks at once, starting by dropping the index, then creating the indices and finally indexing"
  task :all, [:model_name] => :environment do |t, model_name|
    _model_name = model_name[:model_name]
    Rake.application.invoke_task("elastest:drop_index[#{_model_name}]")
    Rake.application.invoke_task("elastest:create_indices[#{_model_name}]")
    Rake.application.invoke_task("elastest:create_index[#{_model_name}]")
  end
end
