module Orders
  class BaseQuery < BaseQuery
    def base_relation
      current_user.orders
    end
  end
end
