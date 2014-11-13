# BotDetection

BotDetection will help you identify users on your site as search engine crawlers or other bots like Facebook spiders.

## Installation

Add this line to your application's Gemfile:

	gem 'bot_detection'

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install bot_detection

## Changes

See the [CHANGELOG.md](CHANGELOG.md) file for details.

## Usage

After installing the GEM you can use within your controllers or helpers the following methods

	# this will return true if user agent and reverse DNS lookup will match one bot out of the database otherwise false is returned
	is_search_engine_crawler?
	
	# this will return true if user agent will match one bot out of the database otherwise false is returned, a reverse dns lookup isn't executed
	is_search_engine_crawler? reverse_lookup: false
	
	# will return true if the current user agent is a known bot otherwise false is returned
	is_known_crawler?
	
	# this will return true if the current user agent is associated with google and the reverse dns lookup will match google.com or googlebot.com
	is_google?

## Contributing

1. Fork it ( https://github.com/sumy/bot_detection/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
