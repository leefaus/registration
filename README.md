## Getting Started
- Install [`homebrew`](http://brew.sh/), `rbenv`, & `postgresql`
  - `brew install rbenv ruby-build`
  - `echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile`
  - `source ~/.bash_profile`
  - `rbenv install 2.2.4`
  - `rbenv global 2.2.4`
  - `rbenv rehash`
  - `brew install postgresql`

- `git checkout https://github.com/githubpartners/registration`
  - _Go to a branch if you want to work on something in progress_
- `cd registration`
- `bundle install`
- `rails db:create`
-  Note: If you get an error after running `rails db:create` e.g. "could not connect to server: Connection refused" your development machine may not recognize postgresql installed from brew.
 - Steps:
  -  Navigate to: http://postgresapp.com/
  -  Download postgresapp
  -  Unzip, copy app to `Applications`
  -  Launch .app file to start server

- `rails db:migrate`
- `rails db:seed`
- `bundle exec figaro install`

## Setup GitHub Enterprise
- Login to GitHub Enterprise
- [Create a new Oauth Application](https://help.github.com/enterprise/admin/guides/user-management/using-github-oauth/)
- The **Homepage URL** should be your **http://LOCAL_VMW_ADDR:3000** (using VMWare Fusion host-only networking)
- The **Authorization Callback URL** should be `http://LOCAL_VMW_ADDR:3000/users/auth/github/callback`
- Once the application is created, save the `client_id` AND `client_secret` to be used later in the `application.yml`
- Create the following key/value pairs corresponding to your install in the `config/application.yml`
  - `github_client_id: <value>`
  - `github_application_secret: <value>`
  - `github_enterprise_url: <value>`

## Running the Application
- `rails s -b 0.0.0.0`
- open your browser to **http://LOCAL_VMW_ADDR:3000** 
