module Comment::Operation
  class Create < Trailblazer::Operation
    step Model(Comment, :new)
    step :save_comment

    def save_comment(ctx, model:, coment_params:, **)
      model.assign_attributes(coment_params)

      model.save
    end
  end
end
