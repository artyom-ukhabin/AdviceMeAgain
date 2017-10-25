namespace :collaborations do
  #TODO: add to deploy
  desc "Update collaborations data for all users"
  task update_for_all: :environment do
    puts "Updating all users collaborations data..."
    User.all.each do |user|
      Collaborations::Service.new.update_collaboration_data(user)
    end
  end

  desc "Update collaborations data for user"
  task :update_for_user, [:user_id] => :environment do |task, args|
    puts "Updating user collaborations data..."
    user = User.find args.user_id
    Collaborations::Service.new.update_collaboration_data(user)
  end
end
