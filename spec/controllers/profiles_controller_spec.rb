require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ProfilesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Profile. As you add validations to Profile, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for(:profile) }
  let(:invalid_attributes) {
    skip("No invalid attributes right now")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProfilesController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:profile_owner) { create(:user) }

  after(:example) do
    expect(assigns(:user)).to eq(profile_owner)
  end

  context "show/new actions" do
    describe "GET #show" do
      it "assigns the requested profile as @profile" do
        profile = profile_owner.create_profile valid_attributes
        get :show, params: {user_id: profile_owner.to_param}, session: valid_session
        expect(assigns(:profile)).to eq(profile)
      end
    end

    describe "GET #new" do
      it 'belongs to profile owner' do
        get :new, params: {user_id: profile_owner.to_param}, session: valid_session
        expect(assigns(:user).profile).to eq assigns(:profile)
      end

      it "assigns a new profile as @profile" do
        get :new, params: {user_id: profile_owner.to_param}, session: valid_session
        expect(assigns(:profile)).to be_a_new(Profile)
      end
    end

    describe "POST #create" do
      context 'for profile owner' do
        context "with valid params" do
          it "creates a new Profile" do
            expect {
              post :create, params: {user_id: profile_owner.to_param, profile: valid_attributes}, session: valid_session
            }.to change(Profile, :count).by(1)
          end

          it 'belongs to profile owner' do
            post :create, params: {user_id: profile_owner.to_param, profile: valid_attributes}, session: valid_session
            expect(assigns(:user).profile).to eq assigns(:profile)
          end

          it "assigns a newly created profile as @profile" do
            post :create, params: {user_id: profile_owner.to_param, profile: valid_attributes}, session: valid_session
            expect(assigns(:profile)).to be_a(Profile)
            expect(assigns(:profile)).to be_persisted
          end

          it "redirects to the created profile" do
            post :create, params: {user_id: profile_owner.to_param, profile: valid_attributes}, session: valid_session
            expect(response).to redirect_to([profile_owner, Profile.last])
          end
        end

        context "with invalid params" do
          it "assigns a newly created but unsaved profile as @profile" do
            post :create, params: {user_id: profile_owner.to_param, profile: invalid_attributes}, session: valid_session
            expect(assigns(:profile)).to be_a_new(Profile)
          end

          it "re-renders the 'new' template" do
            post :create, params: {user_id: profile_owner.to_param, profile: invalid_attributes}, session: valid_session
            expect(response).to render_template("new")
          end
        end
      end
    end
  end

  context 'edit actions' do
    let(:stranger) { create(:user) }

    describe "GET #edit" do
      context 'for profile owner' do
        it "assigns the requested profile as @profile" do
          profile = profile_owner.create_profile valid_attributes
          get :show, params: {user_id: profile_owner.to_param}, session: valid_session
          expect(assigns(:profile)).to eq(profile)
        end
      end

      context 'for stranger' do
        before(:example) do
          #TODO: update after authorization implementation
          skip("Not implemented yet")
        end

        it 'should redirect to root' do
          get :show, params: {user_id: stranger.to_param}, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe "PUT #update" do
      context 'for profile owner' do
        context "with valid params" do
          let(:new_attributes) { attributes_for(:profile) }

          it "updates the requested profile" do
            profile = profile_owner.create_profile valid_attributes
            put :update, params: {user_id: profile_owner.to_param, profile: new_attributes}, session: valid_session
            profile.reload
            expect(profile.attributes).to include new_attributes.stringify_keys
          end

          it "assigns the requested profile as @profile" do
            profile = profile_owner.create_profile valid_attributes
            put :update, params: {user_id: profile_owner.to_param, profile: valid_attributes}, session: valid_session
            expect(assigns(:profile)).to eq(profile)
          end

          it "redirects to the profile" do
            profile = profile_owner.create_profile valid_attributes
            put :update, params: {user_id: profile_owner.to_param, profile: valid_attributes}, session: valid_session
            expect(response).to redirect_to([profile_owner, profile])
          end
        end

        context "with invalid params" do
          it "assigns the profile as @profile" do
            profile = profile_owner.create_profile valid_attributes
            put :update, params: {user_id: profile_owner.to_param, profile: invalid_attributes}, session: valid_session
            expect(assigns(:profile)).to eq(profile)
          end

          it "re-renders the 'edit' template" do
            profile_owner.create_profile valid_attributes
            put :update, params: {user_id: profile_owner.to_param, profile: invalid_attributes}, session: valid_session
            expect(response).to render_template("edit")
          end
        end
      end

      context 'for stranger' do
        before(:example) do
          #TODO: update after authorization implementation
          skip("Not implemented yet")
        end

        it 'should not change profile' do
          profile = profile_owner.create_profile valid_attributes
          put :update, params: {user_id: stranger.to_param, profile: new_attributes}, session: valid_session
          expect(assigns(:profile)).to eq(profile)
        end

        it 'should redirect to root' do
          put :update, params: {user_id: stranger.to_param, profile: new_attributes}, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe "DELETE #destroy" do
      context 'for profile owner' do
        it "destroys the requested profile" do
          profile_owner.create_profile valid_attributes
          expect {
            delete :destroy, params: {user_id: profile_owner.to_param}, session: valid_session
          }.to change(Profile, :count).by(-1)
        end

        it "redirects to the root" do
          profile_owner.create_profile valid_attributes
          delete :destroy, params: {user_id: profile_owner.to_param}, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end

      context 'for stranger' do
        before(:example) do
          #TODO: update after authorization implementation
          skip("Not implemented yet")
        end

        it 'should not destroy profile' do
          profile_owner.create_profile valid_attributes
          expect {
            delete :destroy, params: {user_id: stranger.to_param}, session: valid_session
          }.tonot_ change(Profile, :count)
        end

        it 'should redirect to root' do
          profile_owner.create_profile valid_attributes
          delete :destroy, params: {user_id: stranger.to_param}, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
