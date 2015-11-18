Example Lead Gen Card Endpoint
====================

This is a sample Ruby sinatra app for Twitter lead generation card endpoints.

<img src="screenshot.png" style="width: 70%;"/>

As always, when developing on top of the Twitter platform, you must abide by the [Developer Agreement & Policy](https://dev.twitter.com/overview/terms/agreement-and-policy). 

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/twitterdev/leadgencard-endpoint)

Requirements
---------------

On Heroku, this code sample requires [Memcached Cloud](https://devcenter.heroku.com/articles/memcachedcloud) for the cache. You can install
it using the following command:

	`heroku addons:create memcachedcloud`

Alternatively, the Heroku configuration is already available in the `app.json` file.

Setup
---------------

First, install the required gems:

	`gem install sinatra`
	`gem install dalli`

Next, run the app locally with the following command:

	`ruby web.rb`
	
This simply runs the app on your local machine; you likely want this app running on somewhere publicaly available so that the Twitter servers
can connect to the machine and submit Leads.

Setup on Heroku
----------------

One of the easiest ways to do so is to deploy this code sample directly to Heroku. The below Heroku instructions will accomplish this.

First, click on the below button to deploy to Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/twitterdev/leadgencard-endpoint)

Once this is done, you will have the option to view the server live. Click on the button to view your server, and you should see 
the below landing page:

<img src="public/landing.png" style="width: 70%;"/>

Note that behind the scenes, the deploy created ENV parameters of the format MEMCACHEDCLOUD_*, which the `web.rb` file defaults to. 
If you want to view or configure these parameters, you can view your app's Heroku ENV settings:

For more information on getting the Memcached part working, visit the [Memcached Cloud Heroku page](https://devcenter.heroku.com/articles/memcachedcloud).

Learning how it works
---------------

Now that your server is running, you can go to the root page and get instructions on the following:

1. Testing your lead gen server's capture works
2. Testing with a sample lead gen card and back end
3. Creating a Lead Gen Card, either via the UI or the API

Public example
---------------

For a working example of both the Twitter Lead Gen Card and the lead data being captured
by a back-end server, go to this live example:

https://limitless-ocean-4365.herokuapp.com/
