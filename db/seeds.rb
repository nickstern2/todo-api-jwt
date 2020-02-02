require 'faker'

puts "Destroy everything"
Todo.destroy_all
Item.destroy_all

5.times do

  todo = Todo.create!(
    title: Faker::Lorem.word,
    created_by: User.last.id
  )

  3.times do
    item = Item.create!(
      name: Faker::Movies::StarWars.character,
      done: false,
      todo_id: todo.id
    )
  end
end

