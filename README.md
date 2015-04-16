# elastest

Elastic search test with relational models


The only requirement for installing Elasticsearch is a recent version of Java. Preferably, you should install the latest version of the official Java from www.java.com.


Then, follow the steps on http://www.elastic.co/guide/en/elasticsearch/guide/current/_installing_elasticsearch.html
to install Elasticsearch.

Prepare the database and then run

```ruby
$ rake db:seed
```

to populate the database.


The seeds.rb file can be altered to change the number of records:

```ruby
# sets number of articles to create
article_count = 20000

# sets number of users to create
user_count = 30

# sets number of comments per article
comment_count_per_article = 3
```

Run the commands to drop/create the Article index

```ruby
# drops Article index
rake elastest:drop_index

# creates Article index
rake elastest:create_index

```