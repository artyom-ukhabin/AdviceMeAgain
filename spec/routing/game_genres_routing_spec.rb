require "rails_helper"

RSpec.describe GameGenresController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/game_genres").to route_to("game_genres#index")
    end

    it "routes to #new" do
      expect(:get => "/game_genres/new").to route_to("game_genres#new")
    end

    it "routes to #show" do
      expect(:get => "/game_genres/1").to route_to("game_genres#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/game_genres/1/edit").to route_to("game_genres#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/game_genres").to route_to("game_genres#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/game_genres/1").to route_to("game_genres#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/game_genres/1").to route_to("game_genres#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/game_genres/1").to route_to("game_genres#destroy", :id => "1")
    end

  end
end
