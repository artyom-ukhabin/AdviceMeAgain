#TODO: refactor
module RecommendationsHelper
  def render_collaboration_items(collaborations_data)
    if collaborations_data.blank?
      'No recommendations for now. Rate some other items and come back.'
    else
      render 'recommendations/collaborations_items', collaborations_data: collaborations_data
    end
  end

  def render_regular_recommendations(recommendation_items)
    if recommendation_items.blank?
      'No data yet.'
    else
      render 'recommendations/regular_items', recommendation_items: recommendation_items
    end
  end

  def render_content_related_array(recommendations_data)
    if recommendations_data.blank?
      'No data yet.'
    else
      render 'recommendations/content_related_array', recommendations_data: recommendations_data
    end
  end

  def render_content_related_items(recommendation_items)
    if recommendation_items.blank?
      'No data yet.'
    else
      render 'recommendations/content_related_items', single_type_items: recommendation_items
    end
  end
end
