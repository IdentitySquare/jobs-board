class CompanyPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    user_is_owner?
  end

  def create?
    user_is_owner?
  end

  def edit?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    @user == @record.user
  end
end
