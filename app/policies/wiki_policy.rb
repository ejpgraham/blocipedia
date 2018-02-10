class WikiPolicy < ApplicationPolicy

  def destroy?
    user.admin? || record.user == user
  end

  def delete?
    user.admin? || record.user == user
  end

  def show?
    user.present?
  end

  def edit?
    user.admin? || record.user == user || user_is_collobarator?
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def user_is_collobarator?
    record.collaborators.pluck(:user_id).include?(user.id)
  end

  class Scope
    attr_reader :user, :scope



    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.admin?
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.collaborators.pluck(:user_id).include?(user.id)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.pluck(:user_id).include?(user.id)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end
end
