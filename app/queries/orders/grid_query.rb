module Orders
  class GridQuery < GridQuery
    attr_accessor :operator
    def initialize(params)
      super
      @operator = params[:operator]
    end

    def base_relation
      Orders::BaseQuery.call(current_user: current_user)
    end

    def execute
      self.relation = self.relation.where(user_id: operator) if operator.present?
    end
  end
end
