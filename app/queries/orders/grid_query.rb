module Orders
  class GridQuery < BaseQuery
    attr_accessor :sort

    def initialize(params)
      super
      @sort = params[:sort] || 'created_at'
    end

    def base_relation
      @relation ||= Orders::BaseQuery.call(current_user: current_user)
    end

    def execute
      relation.order("#{sort} DESC")
    end
  end
end
