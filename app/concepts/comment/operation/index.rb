module Comment::Operation
  class Index < Trailblazer::Operation
    step Model(Comment, :new)
    pass :fetch_comments

    def fetch_comments(ctx, post:, **)
      ctx[:comments] = post.comments.includes(:user, :likes)
    end
  end
end
