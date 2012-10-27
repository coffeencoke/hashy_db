group :integration do
  guard 'rspec', :version => 2, spec_paths: ["spec/integration"] do
    watch('Gemfile') { "spec/integration" }
    watch('Gemfile.lock') { "spec/integration" }
    watch('hashy_db.gemspec') { "spec/integration" }
    watch(%r{^spec/integration/.+_spec\.rb$}) { "spec/integration" }
    watch(%r{^lib/(.+)\.rb$}) { "spec/integration" }
    watch(%r{^lib/hashy_db/(.+)\.rb$}) { "spec/integration" }
  end
end

group :units do
  guard 'rspec', :all_after_pass => false, :version => 2, spec_paths: ["spec/units/hashy_db"] do
    watch('Gemfile') { "spec/units" }
    watch('Gemfile.lock') { "spec/units" }
    watch('hashy_db.gemspec') { "spec/units" }
    watch(%r{^spec/units/hashy_db/.+_spec\.rb$})
    watch(%r{^lib/hashy_db/(.+)\.rb})                            { |m| "spec/units/hashy_db/#{m[1]}_spec.rb" }
  end
end
