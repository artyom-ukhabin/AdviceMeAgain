require "rails_helper"

RSpec.describe PersonalityReviewsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/personality_reviews").to route_to("personality_reviews#index")
    end

    it "routes to #new" do
      expect(:get => "/personality_reviews/new").to route_to("personality_reviews#new")
    end

    it "routes to #show" do
      expect(:get => "/personality_reviews/1").to route_to("personality_reviews#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/personality_reviews/1/edit").to route_to("personality_reviews#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/personality_reviews").to route_to("personality_reviews#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/personality_reviews/1").to route_to("personality_reviews#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/personality_reviews/1").to route_to("personality_reviews#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/personality_reviews/1").to route_to("personality_reviews#destroy", :id => "1")
    end

  end
end
