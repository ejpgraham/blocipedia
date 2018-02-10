module WikiHelper

  def body(wiki)
    wiki.body
  end

  def markdown_render(wiki)
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    markdown.render(wiki.body)
  end

  def user_is_collobarator?(wiki)
    wiki.collaborators.pluck(:user_id).include?(current_user.id)
  end

  def user_owns_wiki?(wiki)
    current_user == wiki.user
  end

  def user_is_admin?
    current_user.admin?
  end

  def wiki_is_private_and_user_has_access(wiki)
    wiki.private? && (user_owns_wiki?(wiki) || user_is_admin? ||
      user_is_collobarator?(wiki))
  end

  def wiki_is_public(wiki)
    !wiki.private?
  end



  def all_users_except_for_wiki_creator(wiki)
    User.where.not(id: wiki.user_id)
  end
end
