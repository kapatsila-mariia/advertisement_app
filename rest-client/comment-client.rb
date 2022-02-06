require 'rubygems'
require 'rest-client'
require_relative 'user-client'

def get_all_comments
  sign_in
  response = RestClient::Request.execute( method: :get,
                                          url: @server + "/advertisements/4/comments",
                                          :headers => {:authorization => "Bearer #{@token}"} )

  puts response

end

def get_comment
  sign_in
  response = RestClient::Request.execute( method: :get,
                                          url: @server + "/advertisements/4/comments/4",
                                          :headers => {:authorization => "Bearer #{@token}"} )

  puts response

end

def create_comment
  sign_in
  begin
  response = RestClient::Request.execute( method: :post,
                                          url: @server + "/advertisements/4/comments",
                                          payload: {
                                            comment_text: ""
                                            },
                                          headers: {:authorization => "Bearer #{@token}"} )


  rescue RestClient::ExceptionWithResponse => err
    puts err.response
  end
  puts response
end

def update_comment
  sign_in

  response = RestClient::Request.execute( method: :patch,
                                          url: @server + "/advertisements/4/comments/4",
                                          payload: {
                                            comment_text: "Very nice"
                                          },
                                          headers: {:authorization => "Bearer #{@token}"} )

  puts response
end

def delete_comment
  sign_in

  response = RestClient::Request.execute( method: :delete,
                                          url: @server + "/advertisements/4/comments/7",
                                          :headers => {:authorization => "Bearer #{@token}"} )


  puts response
end

