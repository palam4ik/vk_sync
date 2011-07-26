namespace :rspec do
  RSpec::Core::RakeTask.new(:run) do |t|
    t.pattern = 'spec/**/*_spec.rb'
    t.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/}
  end
end
