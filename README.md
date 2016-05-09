Example Lead Gen Card Endpoint Web Interface
============================================

Welcome!

This is a sample Ruby Sinatra app for capturing and managing leads from [Twitter lead generation cards](https://business.twitter.com/en/help/campaign-editing-and-optimization/optimizing-for-leads-campaigns.html) via the [Twitter Ads Platform](https://ads.twitter.com).


What Exactly Does this App Do? What Problem Does it Address?
------------------------------------------------------------

Here's minimum you need to know in few seconds (bit of Marketing 101):

 - Lead: A person who has indicated interest in your company's product in some form
 - Lead Generation: It's a process of attracting and converting complete strangers INTO LEADS
 - From a business marketing standpoint: "I want try unique ways to attract people to my business. I want to provide people with enough goodies to get them naturally interested enough in my company to hear more from us!"
 - In other words, lead generation is a fancy marketing concept of warming up potential customers to your business and getting them on the path of eventual action (i.e. buying).
 - Rather than the business initiating relationships with customers, it's actually the customers that are the ones initiating the relationship with the business. This small but subtle difference makes it much easier for customers to want to commit to a long term relationship with the business.
 - This process is a crucial part of what is referred to as a "campaign." Think of it as a marketing crusade to convert strangers into loyal customers!

This sample app demonstrates how to use Twitter's lead generation "cards" to capture information on potential leads for your marketing campaign of your business. Here's what Twitter's Lead Generation Card might look like:

![lead gen card](https://github.com/strychemi/leadgencard-endpoint/raw/master/public/eleadgencard.png)

Requirements
------------

It's assumed you already have Ruby, Git, and Heroku toolbelts installed.
If you're completely new to all of this, I'd start with [this great guide for installing various important tools including Ruby, Git, and other required tools](https://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/).

Follow this guide for [heroku toolbelts installation](https://toolbelt.heroku.com/).

Once you've installed all the tools above, run the following command in your terminal/shell.

`gem install bundler`

That's it.

Getting Started
---------------

Go to a directory where you want to store this project.
1. Fork, or download the repository to your local hardrive.
2. `cd leadgencard-endpoint` (change directory into the root directory)
3. `bundle install` (if an error occurs run `bundle update` instead, this finds and automatically downloads the most UPDATED versions of the required Ruby dependencies specified in the Gemfile)
4. `ruby web.rb`

That's pretty much it, to get it run locally (Note: some of the features do not work locally, so it's recommended to go the Heroku-deployed route). If you want to deploy to Heroku follow the additional steps.

5. Create a github new repo and follow Github's instructions on hooking it up to your local downloaded project. (Skip this step if you already forked it).
6. `git push heroku create YOURAPPNAMEHERE`, where YOURAPPNAMEHERE is whatever you want to name your app.
7. `heroku addons:create heroku-postgresql:hobby-dev` (this sets up a PostgreSQL database for your Sinatra app on Heroku)
8. `git push heroku master`
9. `heroku open` or type the URL of your heroku deployed app directly in your browser.

That's it! It's live on the web!

As always, when developing on top of the Twitter platform, you must abide by the [Developer Agreement & Policy](https://dev.twitter.com/overview/terms/agreement-and-policy).

Note: Because of how Heroku-deployed apps start at the default "free-tier", it is not up live 100% and sleeps when it stays inactive too long, so it may actually miss some HTTP requests from the Twitter platform when leads are generated. Please take this into consideration.

Learning how it works
---------------------

Now that your server is running, you can go to the root page and get instructions on the following:

1. Testing your lead gen server's capture works
2. Testing with a sample lead gen card and back end
3. Creating a Lead Gen Card, either via the UI or the API
4. Seeing the currently saved list of lead gen cards you've hooked up.
5. Searching, deleting, managing your list of leads and lead gen cards.
6. Have fun! This is just a sample app that's easily extendable to other features/uses!

Public example
---------------

For a working example of both the Twitter Lead Gen Card and the lead data being captured
by a back-end server, go to this live example:

https://limitless-ocean-4365.herokuapp.com/
