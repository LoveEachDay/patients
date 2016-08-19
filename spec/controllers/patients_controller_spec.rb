require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @john = create(:patient, first_name: 'john')
      @smith = create(:patient, first_name: 'smith')
      @jones = create(:patient, first_name: 'jones', deleted: true)

      get :index
    end

    it "populates an array of patients which doesn't marked as 'deleted'" do
      expect(assigns(:patients)).to match_array([@john, @smith])
    end

    it "populates an array of patients which exclude 'deleted' patients" do
      expect(assigns(:patients)).not_to include(@jones)
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    context "requested patient isn't maked as 'deleted'"do
      before(:each) do
        @patient = create(:patient)

        get :show, id: @patient
      end

      it "assigns the requested patient to @patient" do
        expect(assigns(:patient)).to eq @patient
      end

      it "renders the :show template" do
        expect(response).to render_template :show
      end
    end

    context "requested patient is marked 'deleted'" do
      before(:each) do
        @patient = create(:patient, deleted: true)

        get :show, id: @patient
      end

      it "redirects to patients list" do
        expect(response).to redirect_to patients_path
      end
    end
  end

  describe "GET #new" do
    before(:each) {
      get :new
    }

    it "assigns a new Patient to @patient" do
      expect(assigns(:patient)).to be_a_new(Patient)
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    context "requested patient isn't marked 'deleted'" do
      before(:each) do
        @patient = create(:patient)

        get :edit, id: @patient
      end

      it "assigns the requested patient to @patient" do
        expect(assigns(:patient)).to eq @patient
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end

    context "requested patient is marked 'deleted'" do
      before(:each) do
        @patient = create(:patient, deleted: true)

        get :edit, id: @patient
      end

      it "redirects to patients list" do
        expect(response).to redirect_to patients_path
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before(:each) {
        location = create("location")
        @valid_attributes = attributes_for(:patient, location_id: location)
      }
      it "creates a new Patient" do
        expect {
          post :create, patient: @valid_attributes
        }.to change(Patient, :count).by(1)
      end

      it "assigns a newly created patient as @patient" do
        post :create, patient: @valid_attributes

        expect(assigns(:patient).first_name).to eq @valid_attributes[:first_name]
      end

      it "redirects to the created patient" do
        post :create, patient: @valid_attributes
        expect(response).to redirect_to patient_path(assigns(:patient))
      end
    end

    context "with invalid params" do
      it "does not save the new patient" do
        expect {
          post :create, patient: attributes_for(:invalid_patient)
        }.to_not change(Patient, :count)
      end

      it "re-renders the 'new' template" do
        post :create, patient: attributes_for(:invalid_patient)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before(:each) do
      @patient = create(:patient, first_name: 'Foo', last_name: 'Bar')
    end

    context "with valid params" do
      it "locates the requested @patient" do
        patch :update, id: @patient, patient: attributes_for(:patient)
        expect(assigns(:patient)).to eq(@patient)
      end

      it "changes @patient's attributes" do
        patch :update, id: @patient, patient: attributes_for(:patient, first_name: 'Edward', last_name: 'Garfield')
        @patient.reload

        expect(@patient.first_name).to eq('Edward')
        expect(@patient.last_name).to eq('Garfield')
      end

      it "redirects to the updated patient" do
        patch :update, id: @patient, patient: attributes_for(:patient)
        expect(response).to redirect_to patient_path(@patient)
      end
    end

    context "with invalid params" do
      it "does not change the patient's attributes" do
        patch :update, id: @patient, patient: attributes_for(:patient, first_name: nil, last_name: 'Garfield')
        @patient.reload
        expect(@patient.first_name).to eq('Foo')
        expect(@patient.last_name).to_not eq('Garfield')
      end

      it "re-renders the edit template" do
        patch :update, id: @patient, patient: attributes_for(:invalid_patient)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) {
      @patient = create(:patient)
    }
    it "marks the requested patient as 'deleted'" do
      delete :destroy, id: @patient
      @patient.reload
      expect(@patient.deleted).to be true
    end

    it "does not delete the requested patient" do
      expect{
        delete :destroy, id: @patient
      }.to_not change(Patient, :count)
    end

    it "redirects to the patients list" do
      delete :destroy, id: @patient
      expect(response).to redirect_to patients_path
    end
  end

end
