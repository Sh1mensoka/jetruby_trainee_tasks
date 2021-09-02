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
    execute_defaults
    execute
    relation
  end

  def base_relation
    raise "#{self.class} doesn't have #{__method__} method"
  end

  def execute
  end

  def execute_defaults
  end

  def relation
    @relation ||= base_relation
  end
end
