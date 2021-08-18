ActiveAdmin.register Order do

  sidebar 'API' do
    label "Current API: #{JSON.parse(File.read('./app/admin/order_config.json'))['current_api']}"

    select 'API_selector' do
      JSON.parse(File.read('./lib/order_creator/api_files/api.json')).keys.each {|key| option key, key}
    end

    input type: :submit
  end 

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :s_name, :patronymic, :phone, :email, :weight, :length, :width, :height, :dep_address, :arr_address, :distance, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :s_name, :patronymic, :phone, :email, :weight, :length, :width, :height, :dep_address, :arr_address, :distance, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
