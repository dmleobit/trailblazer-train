module Post::Operation
  class CreateRandom < Trailblazer::Operation
    step Model(Post, :new)
    # same as pass :assign_attributes. Will go to success track even in case of failure
    step :assign_attributes, Output(:failure) => Track(:success) # Track or End

    step Wrap( Shared::CallableTransaction ) {
      step :save
      # Just to show how transactions works in separate steps
      step :create_one_new
    }
    fail :log_error
    step :log

    def assign_attributes(ctx, model:, user:, **)
      model.assign_attributes(
        user: user,
        text: Faker::Lorem.sentence
      )
    end

    def save(ctx, model:, **)
      model.save!
    end

    def create_one_new(ctx, user:, **)
      # First line raise an error
      # Post.create!()
      Post.create!(user: user, text: Faker::Lorem.sentence)
    end

    def log_error(ctx, model:, **)
      Rails.logger.error(model.errors.full_messages)
    end

    def log(ctx, model:, **)
      Rails.logger.info('Posts was created')
    end
  end
end
