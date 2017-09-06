module RecommendationsHelper
  def show_collaboration_data(collaborations_data)
    if collaborations_data.blank?
      'No recommendations for now. Rate some other items and come back.'
    else
      render 'recommendations/collaborations_section', collaborations_data: collaborations_data
    end
  end
end
