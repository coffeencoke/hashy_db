ignore_paths 'spec/integration'

guard 'rspec', :version => 2, spec_paths: ["spec/lib"] do
  watch(%r{^spec/lib/.+_spec\.rb$})
  watch(%r{^lib/hashy_db/(.+)\.rb})          { |m| "spec/lib/hashy_db/#{m[1]}_spec.rb" }
end
