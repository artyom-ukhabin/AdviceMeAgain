require "rails_helper"

RSpec.describe BookGenresController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/book_genres").to route_to("book_genres#index")
    end

    it "routes to #new" do
      expect(:get => "/book_genres/new").to route_to("book_genres#new")
    end

    it "routes to #show" do
      expect(:get => "/book_genres/1").to route_to("book_genres#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/book_genres/1/edit").to route_to("book_genres#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/book_genres").to route_to("book_genres#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/book_genres/1").to route_to("book_genres#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/book_genres/1").to route_to("book_genres#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/book_genres/1").to route_to("book_genres#destroy", :id => "1")
    end

  end
end
