class ContentPostParamsConverter
  class << self
    def for_post_controller(raw_params)
      raw_params[:raw_content_posts_attributes].map do |raw_attributes_hash|
        content_id = get_content_id(raw_attributes_hash[:name])
        raw_attributes_hash.delete(:name)
        raw_attributes_hash.merge!({content_id: content_id})
      end
      raw_params[:content_posts_attributes] = raw_params.delete :raw_content_posts_attributes
      raw_params
    end

    #TODO: with knowledge from phase 2 think about these queries
    def for_edit_post_form(raw_content_data)
      raw_content_data = group_content_data_by_type(raw_content_data)
      clear_content_hashes_from_type(raw_content_data)
      tableize_type_keys(raw_content_data)
      raw_content_data
    end

    private

    def group_content_data_by_type(raw_content_data)
      raw_content_data.group_by do |content_hash|
        content_hash[:type]
      end
    end

    def clear_content_hashes_from_type(raw_content_data)
      raw_content_data.each do |type, content_hashes_array|
        content_hashes_array.each do |content_hash|
          content_hash.delete :type
        end
      end
    end

    def tableize_type_keys(raw_content_data)
      raw_content_data.keys.each do |type|
        raw_content_data[type.tableize] = raw_content_data.delete(type)
      end
    end

    def get_content_id(content_name)
      Content.by_name(content_name).to_param
    end
  end
end