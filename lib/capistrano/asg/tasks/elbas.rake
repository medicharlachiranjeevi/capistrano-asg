require 'capistrano/asg'

namespace :asg do
  task :scale do
    set :aws_access_key_id,     fetch(:aws_access_key_id,     ENV['AWS_ACCESS_KEY_ID'])
    set :aws_secret_access_key, fetch(:aws_secret_access_key, ENV['AWS_SECRET_ACCESS_KEY'])
    set :aws_region,            fetch(:aws_region,            ENV['AWS_REGION'])

    Capistrano::Asg::AMI.create do |ami|
      puts "Autoscaling: Created AMI: #{ami.aws_counterpart.id}"
      Capistrano::Asg::LaunchConfiguration.create(ami) do |lc|
        puts "Autoscaling: Created Launch Configuration: #{lc.aws_counterpart.name}"
        lc.attach_to_autoscale_group!
      end
    end
  end
end