require "rails_helper"

RSpec.describe MovieGenresController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/movie_genres").to route_to("movie_genres#index")
    end

    it "routes to #new" do
      expect(:get => "/movie_genres/new").to route_to("movie_genres#new")
    end

    it "routes to #show" do
      expect(:get => "/movie_genres/1").to route_to("movie_genres#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/movie_genres/1/edit").to route_to("movie_genres#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/movie_genres").to route_to("movie_genres#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/movie_genres/1").to route_to("movie_genres#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/movie_genres/1").to route_to("movie_genres#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/movie_genres/1").to route_to("movie_genres#destroy", :id => "1")
    end

  end
end
