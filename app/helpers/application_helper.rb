module ApplicationHelper
  def mobile?
    request.user_agent =~ /(Android|iPhone|iPod)/
  end
end