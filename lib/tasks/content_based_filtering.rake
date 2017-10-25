namespace :content_based_filtering do
  #TODO: URGENT: include in deploy script
  desc "Import all content based data"
  task import_all: :environment do
    puts "Importing all content based data..."
    import_all_content
    import_all_personalities
    update_all_users_data
    update_all_recommendations_data
  end

  #TODO: for technical use only
  desc 'Destroying content based data(technical use only)'
  task destroy_all: :environment do
    puts "Destroying all content based data..."
    Elastic::ContentBased::ContentVector.all.results.each{|a| a.destroy}
    Elastic::ContentBased::PersonalityVector.all.results.each{|a| a.destroy}
    Elastic::ContentBased::UserContentPreferenceVector.all.results.each{|a| a.destroy}
    Elastic::ContentBased::UserPersonalitiesPreferenceVector.all.results.each{|a| a.destroy}
    Elastic::ContentBased::ContentPrediction.all.results.each{|a| a.destroy}
    Elastic::ContentBased::PersonalityPrediction.all.results.each{|a| a.destroy}
  end

  desc "Update content based data for all users"
  task update_for_all_users: :environment do
    puts "Updating content based data for all users..."
    update_all_users_data
    update_all_recommendations_data
  end

  desc "Update content based data for user"
  task :update_for_user, [:user_id] => :environment do |task, args|
    puts "Updating content based data for user..."
    user = User.find args.user_id
    update_user_data(user)
    update_recommendations_data(user)
  end

  def import_all_content
    ContentBasedFiltering::ItemImporters::ContentImporter.new.import
  end

  def import_all_personalities
    ContentBasedFiltering::ItemImporters::PersonalitiesImporter.new.import
  end

  def update_all_users_data
    User.all.each do |user|
      update_user_data(user)
    end
  end

  def update_user_data(user)
    update_content_user_data(user)
    update_user_personalities_data(user)
  end

  def update_content_user_data(user)
    Content::TYPES.map(&:capitalize).each do |type|
      ContentBasedFiltering::ItemUpdaters::UserContentUpdater.new.update(user, type)
    end
  end

  def update_user_personalities_data(user)
    ContentBasedFiltering::ItemUpdaters::UserPersonalitiesUpdater.new.
      update_for_several_types(user, Content::TYPES.map(&:capitalize))
  end

  def update_all_recommendations_data
    User.all.each do |user|
      update_recommendations_data(user)
    end
  end

  def update_recommendations_data(user)
    update_content_recommendations(user)
    update_personality_recommendations(user)
  end

  def update_content_recommendations(user)
    Content::TYPES.map(&:capitalize).each do |type|
      ContentBasedFiltering::ItemUpdaters::ContentRecommendationsUpdater.new.update_all_for_type(type)
    end
  end

  def update_personality_recommendations(user)
    ContentBasedFiltering::ItemUpdaters::PersonalityRecommendationsUpdater.new.
      update_for_several_types(user, Content::TYPES.map(&:capitalize))
  end
end