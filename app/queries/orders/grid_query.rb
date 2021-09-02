module Orders
  class GridQuery < GridQuery
    def base_relation
      Orders::BaseQuery.call(current_user: current_user)
    end
  end
end
