ActiveAdmin.register Profile do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, :city, :info

  index do
    column :name
    column :city
    column :info
    actions
  end

  form do |f|
    f.inputs "Profile Details" do
      f.input :name
      f.input :city
      f.input :info
    end
    f.actions
  end
end