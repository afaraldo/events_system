class EventPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index?
    user.role_admin? || user.role_user?
  end

  def show?
    user.role_admin? || record.user == user
  end

  def create?
    user.role_admin? || user.role_user?
  end

  def update?
    user.role_admin? || record.user == user
  end

  def destroy?
    user.role_admin? || record.user == user
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      if user.role_admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
