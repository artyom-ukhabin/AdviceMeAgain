require "rails_helper"

RSpec.describe BandGenresController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/band_genres").to route_to("band_genres#index")
    end

    it "routes to #new" do
      expect(:get => "/band_genres/new").to route_to("band_genres#new")
    end

    it "routes to #show" do
      expect(:get => "/band_genres/1").to route_to("band_genres#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/band_genres/1/edit").to route_to("band_genres#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/band_genres").to route_to("band_genres#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/band_genres/1").to route_to("band_genres#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/band_genres/1").to route_to("band_genres#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/band_genres/1").to route_to("band_genres#destroy", :id => "1")
    end

  end
end
