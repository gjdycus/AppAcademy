# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

jamal = User.create!(user_name: "ballislife")
rutherford = User.create!(user_name: "chess4life")
poll = Poll.create!(title: "Favorite ninja turtle", author_id: jamal.id)
question = Question.create!(poll_id: poll.id, body: "Michaelangelo? Rafael?? Leonardo?!? Donatello?!?!!")
answer_choice_m = AnswerChoice.create!(item: "Michaelangelo", question_id: question.id)
answer_choice_r = AnswerChoice.create!(item: "Rafael", question_id: question.id)
answer_choice_l = AnswerChoice.create!(item: "Leonardo", question_id: question.id)
answer_choice_d = AnswerChoice.create!(item: "Donatello", question_id: question.id)
response = Response.create!(user_id: jamal.id, answer_choice_id: answer_choice_r.id)
response = Response.create!(user_id: rutherford.id, answer_choice_id: answer_choice_d.id)
