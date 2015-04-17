# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# sets number of articles to create
article_count = 200

# sets number of users to create
user_count = 30

# sets number of comments per article
comment_count_per_article = 3

first_names = [ 'Pedro', 'Raluca', 'Patrick', 'Ivo', 'Guilherme', 'Marta', 'Sónia', 'Ana',
   'Silvia', 'João', 'Daniel', 'Carlos' ]
last_names = [ 'Coutinho', 'Silva', 'Mourinho', 'Rodrigues', 'Pinto', 'Santos', 'Oliveira', 'Dias']

# Sample text from lorem ipsum translations
article_text = [
  'But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain.',
  'No one rejects, dislikes, or avoids pleasure itself, because it is pleasure.',
  'But because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.',
  'Nor again is there anyone who loves or pursues or desires to obtain pain of itself.',
  'On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure.',
  'In a free hour.',
  'It will frequently occur that pleasures have to be repudiated and annoyances accepted.',
  'He rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.',
  'Nor again is there anyone who loves or pursues or desires to obtain pain of itself.',
  'Laborious physical exercise.',
  'But in certain circumstances and owing to the claims.'
]
comment_number = 1
display_percent = 0

STDOUT.write "\rSeeding the database... #{display_percent}%"

user_count.times do
  _first_name = first_names[Random.new.rand(0..11)]
  _last_name = last_names[Random.new.rand(0..7)]
  _email = I18n.transliterate(_first_name).downcase +
    '.' + I18n.transliterate(_last_name).downcase + '.' + Random.new.rand(10..99).to_s + '@cenas.pt'
  @user = User.new(name: _first_name + ' ' + _last_name, email: _email)
  @user.save!
end

1.times do
  article_count.times do
    @user = User.find(Random.new.rand(1..User.all.count))
    _article_text = article_text[Random.new.rand(0..10)] + ' ' +
      article_text[Random.new.rand(0..10)] + ' ' + article_text[Random.new.rand(0..10)]
    @article = Article.new(title: article_text[Random.new.rand(0..10)], text: _article_text, status: Random.new.rand(0..1), user_id: @user.id )
    @article.save!
    comment_count_per_article.times do
      current_percent = comment_number * 100 / (article_count * comment_count_per_article)
      if display_percent != current_percent
        display_percent = current_percent
        STDOUT.write "\rSeeding the database... #{display_percent}%"
      end
      comment_number += 1
      @comment = Comment.new(body: article_text[Random.new.rand(0..10)], article_id: @article.id, user_id: Random.new.rand(1..(User.all.count)))
      @comment.save!
    end
  end
  puts "\n"
end
