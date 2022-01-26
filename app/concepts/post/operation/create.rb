module Post::Operation
  class Create < Trailblazer::Operation
    class CreateContract < Reform::Form
      property :text
      property :user do
        property :email
      end

      validates :text, presence: true
      validates :user, presence: true
    end

    step Model( Post, :new )
    step :assign_user_values
    step Contract::Build(constant: CreateContract)
    step Contract::Validate()
    step Contract::Persist()
    step :create_notifications

    def assign_user_values(ctx, **)
      ctx['model'].user = ctx[:current_user]
    end

    # Just to show behaviour like model callback
    def create_notifications(ctx, **)
      friend_entities = ctx[:current_user].sent_requests
                                          .or(ctx[:current_user].received_requests)
                                          .includes(:initiator, :receiver)
                                          .accepted

      friend_entities.each do |friend_entity|
        receiver = friend_entity.initiator == ctx[:current_user] ? friend_entity.receiver : friend_entity.initiator

        receiver.notifications.create(
          text: "Your friend #{ctx[:current_user].email} created new post. Please take a look",
          notification_type: Notification::FRIEND
        )
      end    
    end
  end
end
