class AddingDefaultAdminUser < ActiveRecord::Migration[7.0]
  def change
    user = UserRepository.find_by_email("admin@nordhen.com")
    unless user
      User.create(name: "Norden Administrator", email: "admin@nordhen.com", roles: ["admin"])
      puts "User admin created!!"
    end
  end
end
