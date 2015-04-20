# elastest

Elastic search test with relational models

This dummy project uses the gem [elasticsearch-rails](https://github.com/elastic/elasticsearch-rails).

The only requirement for installing Elasticsearch is a recent version of Java. Preferably, you should install the latest version of the official Java from www.java.com.

Then, follow the steps on [the official guide](http://www.elastic.co/guide/en/elasticsearch/guide/current/_installing_elasticsearch.html) to install Elasticsearch.

Prepare the database and then run

```bash
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
Note: On this project only the Article model is enabled for indexing

```bash
# drops Article index
$ rake elastest:drop_index[model_name]

# creates article indices
$ rake elastest:create_indices[model_name]

# creates Article index
$ rake elastest:create_index[model_name]

```

Elastic search is accessible at [http://localhost:9200/articles/article/1](http://localhost:9200/articles/article/1)
(will show first article).

Rails version is at [http://localhost:3000/search](http://localhost:3000/search).

Usefull links for elastic:

```bash
# shows statistics
http://localhost:9200/_stats

# shows the mappings
http://localhost:9200/articles/article/_mapping
```

Aditional information can be found [here on this cheat sheet](http://elasticsearch-cheatsheet.jolicode.com/)