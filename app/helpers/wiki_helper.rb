module WikiHelper

  def wiki_is_private_and_user_has_access(wiki)
    wiki.private? && (current_user == wiki.user || current_user.admin?)
  end

  def wiki_is_public(wiki)
    !wiki.private?
  end

end
