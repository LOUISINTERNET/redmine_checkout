begin
  require "spec/rake/spectask"
  namespace :spec do
    namespace :plugins do
      desc "Runs the examples for redmine_checkout"
      Spec::Rake::SpecTask.new(:redmine_checkout) do |t|
        t.spec_opts = ['--options', "\"#{Rails.root}/spec/spec.opts\""]
        t.spec_files = FileList['plugins/redmine_checkout/spec/**/*_spec.rb']
      end
    end
  end
  task :spec => "spec:plugins:redmine_checkout"
rescue LoadError
end
