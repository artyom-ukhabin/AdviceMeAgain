require "rails_helper"

RSpec.describe ContentReviewsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/content_reviews").to route_to("content_reviews#index")
    end

    it "routes to #new" do
      expect(:get => "/content_reviews/new").to route_to("content_reviews#new")
    end

    it "routes to #show" do
      expect(:get => "/content_reviews/1").to route_to("content_reviews#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/content_reviews/1/edit").to route_to("content_reviews#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/content_reviews").to route_to("content_reviews#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/content_reviews/1").to route_to("content_reviews#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/content_reviews/1").to route_to("content_reviews#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/content_reviews/1").to route_to("content_reviews#destroy", :id => "1")
    end

  end
end
