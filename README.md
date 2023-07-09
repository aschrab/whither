# README

This is a basic Ruby on Rails app to display weather for a specified address in
the US.

## Configuration

This application requires two environment variables to be set with API keys.

The first is `GOOGLE_MAP_API_KEY`, which is used to get information about the
entered address such as the zipcode and geographic coordinates. Instructions for
getting a key can be found at
<https://cloud.google.com/docs/authentication/api-keys>.

The second required variable is `OPENWEATHER_API_KEY`. This is used to retrieve
weather information for the coordinates obtained from the previous API.
Instructions for creating these API keys can be found at
<https://openweathermap.org/api>.

## Running

This application was developed using Ruby version 3.2.2, and it is recommended
that Ruby 3.2.x is used to run it. It may work with other versions, but that
hasn't been tested.

```bash
bundle # Install dependencies specified in `Gemfile`
rails dev:cache # Toggle caching in dev mode to on (assuming it wasn't already on)
rails server # Start development-mode server
```

The last command there will display a URL, which you can open in your web
browser to use the application.

## Class descriptions

### Models

#### Temperature

A simple class to represent a temperature. It supports any of the following
temperature scales:

* Kelvin
* Degrees Celsius
* Degrees Fahrenheit

Read and write acccessors are available for all of those scales. When
initializing, the desired scale can be passed as a Symbol in the second argument
with `:kelvin` being the default.

#### ApiClient concern

Some common functionality for working with the geolocation and weather APIs.

#### Location

Use a geolocation API to get zipcode and coordinates for an address passed as a
String.

#### Weather

Use an API to get weather information for a Location. The passed location must
respond to the following methods:

* #zipcode
* #latitude
* #longitude

### Controllers

#### Weather

Present a form for the user to enter an address, and display weather at that
address.
