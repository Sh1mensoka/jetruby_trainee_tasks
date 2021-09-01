class BaseQuery
  attr_accessor :current_user, :relation

  def initialize(params)
    @current_user = params[:current_user]
    @relation = nil
  end

  def self.call(params)
    new(params).call
  end

  def call
    base_relation
    execute
  end

  def base_relation
    raise NotImplementedError, "#{self.class} doesn't implement #{__method__} method"
  end

  def execute
    raise NotImplementedError, "#{self.class} doesn't implement #{__method__} method"
  end
end
