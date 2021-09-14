module Users
  class BaseQuery < BaseQuery
    def base_relation
      if current_user.admin?
        User.where(organisation_id: current_user.organisation_id, role: 'operator')
      else
        User.none
      end
    end
  end
end
