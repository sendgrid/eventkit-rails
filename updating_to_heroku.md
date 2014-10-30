# Upgrading EventKit to your Heroku Account

These instructions are for those who previously deployed EventKit to a Heroku account (whether manually or using the "Deploy to Heroku" button), and would like to update the application with changes that might have been pushed to this repo.

## Step 1 - Clone The Project

First off, clone the project to your computer using git.

```shell
# First, go to a location that you want to copy the project to
cd /pick/a/path/to/clone/to
# Then clone it to that location
git clone https://github.com/sendgrid/eventkit-rails
```

## Step 2 - Find Your Heroku Git URL

Next, login to your Heroku account and select your current EventKit rails application.  Go to the "Settings" page and find your "Git URL" under info:

![](https://s3.amazonaws.com/uploads.hipchat.com/17705/353698/wOpDcgTGJqPy2Tw/heroku_origin.png)

## Step 3 - Add As A Remote

Add that Heroku Git URL as a remote repository to your cloned copy of the EventKit-Rails project:

```shell
# Go to the location of your cloned project
cd /path/to/eventkit-rails
# Add your Heroku Git URL as a remote
# Replace the below URL with the URL you found in Step 2
git remote add heroku git@heroku.com:eventkit-rails-upgrade-demo.git
```

## Step 4 - Push Latest Changes To Your Heroku URL

Finally, you can push the latest and greatest changes to your Heroku URL by running the following:

```shell
# Go to the location of your cloned project
cd /path/to/eventkit-rails
# Push the updates!
git push heroku master
```

The latest changes will be uploaded to your Heroku account!