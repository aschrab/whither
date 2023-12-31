module ApiClient
  # Generate URL for the API request
  #
  # @return [URL] URL which will be used to retrieve data from that API
  def url
    uri = URI.parse base_uri
    uri.query = URI.encode_www_form params
    uri
  end

  # Is this based on cached data
  #
  # @returns [Boolean]
  def cached? = @cached

  # Make HTTP request to get data from address returned by #url method
  #
  # @return [String] the HTTP response body
  def get
    @cached = true
    Rails.cache.fetch(self, expires_in: cache_for) do
      @cached = false
      Net::HTTP.get(url)
    end
  end

  # Parse JSON data returned by #get method, this may include metadata
  #
  # @return [Hash]
  def parse
    JSON.parse get
  end

  # Access cached version of API response data
  #
  # @return [Hash]
  def data
    @data ||= parse
  end
end
