module Comment::Operation
  class Like < Trailblazer::Operation
    step Nested(Shared::Operation::Like), fast_track: true
  end
end
