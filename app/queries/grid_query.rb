class GridQuery < BaseQuery
  attr_accessor :current_page, :orders_per_page, :sort

  def initialize(params)
    super
    @current_page = params[:page]
    @orders_per_page = params[:orders_per_page]
    @sort = params[:sort] || 'created_at'
  end

  def execute_defaults
    super
    self.relation = self.relation.order("#{sort} DESC")
    self.relation = self.relation.page(current_page).per(orders_per_page)
  end
end