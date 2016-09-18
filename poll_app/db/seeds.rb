# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(name: "name1")
User.create(name: "name2")
User.create(name: "name3")
User.create(name: "name4")
User.create(name: "name5")

Poll.create(title: "title 1", author_id: 2)
Poll.create(title: "title 2", author_id: 2)
Poll.create(title: "title 3", author_id: 3)
Poll.create(title: "title 4", author_id: 4)
Poll.create(title: "title 5", author_id: 4)

# Question.create(text: "Question number 1", poll_id: 1)
# Question.create(text: "Question number 1", poll_id: 1)
# Question.create(text: "Question number 1", poll_id: 1)
# Question.create(text: "Question number 2", poll_id: 1)
# Question.create(text: "Question number 2", poll_id: 1)
# Question.create(text: "Question number 2", poll_id: 3)
# Question.create(text: "Question number 3", poll_id: 1)
# Question.create(text: "Question number 3", poll_id: 2)
# Question.create(text: "Question number 3", poll_id: 3)
# Question.create(text: "Question number 4", poll_id: 1)
# Question.create(text: "Question number 4", poll_id: 2)
# Question.create(text: "Question number 4", poll_id: 3)
# Question.create(text: "Question number 5", poll_id: 1)
# Question.create(text: "Question number 5", poll_id: 2)
# Question.create(text: "Question number 5", poll_id: 3)

5.times do |num|
  5.times do |num2|
    Question.create(poll_id: num+1, text: "answer choice no. #{num2+1}")
  end
end


5.times do |num|
  5.times do |num2|
    AnswerChoice.create(question_id: num+1, text: "answer choice no. #{num2+1}")
  end
end

Response.create(user_id: 1, answer_choice_id: 1)
Response.create(user_id: 1, answer_choice_id: 6)
Response.create(user_id: 1, answer_choice_id: 11)
Response.create(user_id: 1, answer_choice_id: 16)
Response.create(user_id: 1, answer_choice_id: 21)
Response.create(user_id: 2, answer_choice_id: 1)
Response.create(user_id: 3, answer_choice_id: 3)
Response.create(user_id: 4, answer_choice_id: 3)
Response.create(user_id: 5, answer_choice_id: 5)
