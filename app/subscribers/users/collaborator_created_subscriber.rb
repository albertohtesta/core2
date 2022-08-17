module Users
  class CollaboratorCreatedSubscriber < ApplicationSubscriber
    from_queue "core.collaborator_user.created"

    def work(payload)
      puts "hola"
      ack!
    end
  end
end
