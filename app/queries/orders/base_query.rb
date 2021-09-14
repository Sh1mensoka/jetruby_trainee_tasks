module Orders
  class BaseQuery < BaseQuery
    def base_relation
      if current_user.admin?
        Order.joins(:user).where(user: {organisation_id: current_user.organisation_id})
      else
        current_user.orders
      end
    end
  end
end
