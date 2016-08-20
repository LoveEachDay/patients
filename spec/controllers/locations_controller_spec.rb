require 'rails_helper'

RSpec.describe LocationsController, type: :controller do

  describe "GET #show" do
    before(:each) do
      @location = create(:location)

      get :show, id: @location
    end

    it "assigns the requested location to @location" do
      expect(assigns(:location)).to eq @location
    end

    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

end
