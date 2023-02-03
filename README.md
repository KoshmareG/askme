# AskMe

Ruby on Rails AskMe. An application where you can ask questions and get answers.

* Ruby version: 3.1.2
* Ruby on Rails version: 7.0.4
* Database adapter: PostgreSQL

Before starting, run:

```
$ bundle
```

Next you need to configure `credentials.yml.enc`. To do this, delete the `config/credentials.yml.enc` file and run the command:

```
$ EDITOR="vim" rails credentials:edit
```

You can use the vim or nano editor.

Then run the commands:

```
$ rails db:create
$ rails db:migrate
```

Run app:

```
$ rails s
```

### Production

In the production environment, add to `config/credentials.yml.enc`:

```
database_username: #Your databse username
database_password: #Your datatbase password
```
