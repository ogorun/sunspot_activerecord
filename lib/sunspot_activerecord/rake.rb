
namespace :sunspot do
  desc "Reindex all solr models that are located in your application's models directory."
  # This task depends on the standard Rails file naming \
  # conventions, in that the file name matches the defined class name. \
  # By default the indexing system works in batches of 50 records, you can \
  # set your own value for this by using the batch_size argument. You can \
  # also optionally define a list of models to separated by a forward slash '/'
  #
  # $ rake sunspot:reindex # reindex all models
  # $ rake sunspot:reindex[1000] # reindex in batches of 1000
  # $ rake sunspot:reindex[false] # reindex without batching
  # $ rake sunspot:reindex[,Post] # reindex only the Post model
  # $ rake sunspot:reindex[1000,Post] # reindex only the Post model in
  # # batchs of 1000
  # $ rake sunspot:reindex[,Post+Author] # reindex Post and Author model
  task :reindex, [:batch_size, :models, :models_path] => [:environment] do |t, args|
    reindex_options = {:batch_commit => false}
    case args[:batch_size]
    when 'false'
      reindex_options[:batch_size] = nil
    when /^\d+$/
      reindex_options[:batch_size] = args[:batch_size].to_i if args[:batch_size].to_i > 0
    end

    if args[:models] and !args[:models].empty?
      sunspot_models = args[:models].split('+').map{ |m| m.constantize }
    else
      models_path = args[:models_path] || './app/models'
      all_files = Dir.glob(File.join(models_path, ['*.rb']))
      all_models = all_files.map { |path| path.sub(models_path.to_s, '')[0..-4].camelize.sub(/^::/, '').constantize rescue nil }.compact
      sunspot_models = all_models.select { |m| m < ActiveRecord::Base and m.searchable? }
    end

    sunspot_models.each do |model|
      model.solr_reindex reindex_options
    end
  end

end
