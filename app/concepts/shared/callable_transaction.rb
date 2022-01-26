module Shared
  class CallableTransaction
    def self.call((ctx, flow_options), *, &block)
      ActiveRecord::Base.transaction { yield } # calls the wrapped steps
    rescue ActiveRecord::RecordInvalid => e
      [ Trailblazer::Operation::Railway.fail!, [ctx, flow_options] ]
    end
  end
end
