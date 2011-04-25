require 'sunspot'

sunspot_activerecord_include_dir = File.expand_path(File.dirname(__FILE__) + '/sunspot_activerecord')
require File.join(sunspot_activerecord_include_dir, 'adapters')
require File.join(sunspot_activerecord_include_dir, 'searchable')

Sunspot::Adapters::InstanceAdapter.register(SunspotActiveRecord::Adapters::ActiveRecordInstanceAdapter, ActiveRecord::Base)
Sunspot::Adapters::DataAccessor.register(SunspotActiveRecord::Adapters::ActiveRecordDataAccessor, ActiveRecord::Base)
ActiveRecord::Base.module_eval { include(SunspotActiveRecord::Searchable) }

module SunspotActiveRecord
end
