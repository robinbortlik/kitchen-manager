# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'coffeescript', :output => 'spec/javascripts/compiled' do
  watch(%r{^spec/javascripts/models/(.+\.coffee)$})
end

guard 'coffeescript', :output => 'public/javascripts/compiled' do
  watch(%r{^app/js/(.+\.coffee)$})
end