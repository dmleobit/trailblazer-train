module Comment::Operation
  class Create < Trailblazer::Operation
    step Model(Comment, :new)
    step Contract::Build(constant: Comment::Contract::Create)
    step Contract::Validate() # optional parameter - key
    step Contract::Persist()
  end
end
