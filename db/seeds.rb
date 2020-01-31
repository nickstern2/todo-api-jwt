require 'faker'
puts "Destroy everything"
Todo.destroy_all
Item.destroy_all

5.times do
  puts "Making 5 todos"
  todo = Todo.create!(
    title: Faker::Lorem.word,
    created_by: Faker::Number.number(10)
  )
  puts "Created 5 todos"

  puts "Making 3 Items for each Todo"

  3.times do
    item = Item.create!(
      name: Faker::Movies::StarWars.character,
      done: false,
      todo_id: todo.id
    )
    puts "Created 3 items"
  end
end

