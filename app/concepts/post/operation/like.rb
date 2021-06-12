module Post::Operation
  class Like < Trailblazer::Operation
    pass :destroy_like, fast_track: true
    step :create_like

    def destroy_like(ctx, user:, origin:, **)
      if origin.likes.find_by(user: user)&.destroy
        ctx[:message] = 'Disliked'
        ctx[:flash_type] = 'alert'
        return Trailblazer::Activity::FastTrack::PassFast
      end
    end

    def create_like(ctx, user:, origin:, **)
      origin.likes.create(user: user)
      ctx[:message] = 'Liked'
      ctx[:flash_type] = 'notice'
    end
  end
end
