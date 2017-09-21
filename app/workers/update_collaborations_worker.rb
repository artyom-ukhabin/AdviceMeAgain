class UpdateCollaborationsWorker
  #TODO: add spinners

  include Sidekiq::Worker

  def perform(items_type, user_id)
    collaboration_service = set_collaboration_service(items_type)
    user = set_user(user_id)
    collaboration_service.update_collaboration_data(user)
  end

  private

  def set_user(user_id)
    User.find user_id
  end

  def set_collaboration_service(items_type)
    Collaborations::Service.new([items_type.downcase])
  end
end
