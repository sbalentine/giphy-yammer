class ApplicationController < ActionController::Base
  
  require 'rest-client'
  require 'json'
  require 'open-uri'

  protect_from_forgery

  def post
  	token = params[:token]
  	gif_url = params[:gif_url]
  	file = RestClient.get(gif_url)
	file_response = JSON.parse(RestClient.post('https://files.yammer.com/v2/files', file, :authorization => "Bearer " + token, content_disposition:"attachment;filename=#{File.basename(gif_url)}"))
	file_id = file_response['id']
	message_response = JSON.parse(RestClient.post("https://www.yammer.com/api/v1/messages.json?access_token=#{token}&body=&attached_objects[]=uploaded_file:#{file_id}", nil))
  end

end
