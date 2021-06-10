module Post::Operation
  class CreateRandom < Trailblazer::Operation
    step Model(Post, :new)
    pass :assign_attributes
    step :save
    fail :log_error
    step :log

    def assign_attributes(ctx, model:, user:, **)
      model.assign_attributes(
        user: user,
        text: Faker::Lorem.sentence
      )
    end

    def save(ctx, model:, **)
      model.save
    end

    def log_error(ctx, model:, **)
      Rails.logger.error(model.errors.full_messages)
    end

    def log(ctx, model:, **)
      Rails.logger.info('Posts was created')
    end
  end
end
