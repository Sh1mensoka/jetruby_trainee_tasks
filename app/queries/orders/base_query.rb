module Orders
  class BaseQuery < BaseQuery
    def base_relation
      @relation ||= current_user.orders
    end

    def execute
      relation
    end
  end
end
