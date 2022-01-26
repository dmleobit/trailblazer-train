class Post::Cell < Cell::Concept
  def show
    render
  end

  private

  def like_count
    model.likes.count
  end

  def link_to_comments
    link_to  "Comments", comments_path(model)
  end
end
