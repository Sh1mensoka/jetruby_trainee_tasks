ActiveAdmin.register Order do
  batch_action :set_status_to_accepted do |ids|
    batch_action_collection.find(ids).each do |order|
      order.update(status: 'accepted')
    end
    redirect_to collection_path
  end

  batch_action :set_status_to_processing do |ids|
    batch_action_collection.find(ids).each do |order|
      order.update(status: 'processing')
    end
    redirect_to collection_path
  end 

  batch_action :set_status_to_sent do |ids|
    batch_action_collection.find(ids).each do |order|
      order.update(status: 'sent')
    end
    redirect_to collection_path
  end  

  batch_action :set_status_to_delivered do |ids|
    batch_action_collection.find(ids).each do |order|
      order.update(status: 'delivered')
    end
    redirect_to collection_path
  end  

  batch_action :set_status_to_cancelled do |ids|
    batch_action_collection.find(ids).each do |order|
      order.update(status: 'cancelled')
    end
    redirect_to collection_path
  end  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :s_name, :patronymic, :phone, :email, :weight, :length, :width, :height, :dep_address, :arr_address, :distance, :price, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :s_name, :patronymic, :phone, :email, :weight, :length, :width, :height, :dep_address, :arr_address, :distance, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
