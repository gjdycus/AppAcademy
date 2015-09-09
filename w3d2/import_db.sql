DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id REFERENCES users(id)
);

CREATE TABLE questions_follows(
  id INTEGER PRIMARY KEY,
  user_id REFERENCES users(id),
  question_id REFERENCES questions(id)
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  subject_question_id REFERENCES questions(id),
  parent_reply_id REFERENCES replies(id),
  user_id REFERENCES users(id),
  body TEXT NOT NULL
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id REFERENCES users(id),
  question_id REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Garrett', 'Dycus'),
  ('Mihir', 'Jham'),
  ('Peyton', 'Manning'),
  ('Tom', 'Brady'),
  ('Colin', 'Kaepernick');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('The Art of War', 'He who must die, dies?', 1),
  ('DeflateGate', 'Did Tom cheat?', 2),
  ('Life', 'What is the answer to life, the universe and everthing?', 3),
  ('NFL', 'When does the season start?', 4),
  ('Cooking', 'How do I make a mean pork chop?', 1);

INSERT INTO
  questions_follows (user_id, question_id)
VALUES
  (2,2),
  (4,2),
  (1,3),
  (5,1);

INSERT INTO
  replies (subject_question_id, parent_reply_id, user_id, body)
VALUES
  (1, NULL, 3, 'Yes'),
  (1, 1, 4, 'Not really'),
  (1, 2, 5, 'Hey guys, I am here too'),
  (2, NULL, 4, 'No comment'),
  (2, 4, 3, '...'),
  (3, NULL, 1, '42');

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (2,4),
  (4,2),
  (5,1),
  (1,1),
  (3,2),
  (4,5);
