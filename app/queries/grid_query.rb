class GridQuery < BaseQuery
  attr_accessor :current_page, :items_per_page, :sort

  def initialize(params)
    super
    @current_page = params[:page]
    @items_per_page = params[:items_per_page]
    @sort = params[:sort] || 'created_at'
  end

  def execute_defaults
    super
    self.relation = self.relation.order("#{sort} DESC") if sort.present?
    self.relation = self.relation.page(current_page).per(items_per_page)
  end
end