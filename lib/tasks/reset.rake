desc 'Resets the application to a clean slate'
task :reset do
  %w( db:reset user generate ).each do |task|
    Rake::Task[task].invoke
  end
end
