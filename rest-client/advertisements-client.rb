require 'rubygems'
require 'rest-client'
require_relative 'user-client'

def get_all_adverts
  sign_in
  response = RestClient::Request.execute( method: :get,
                                          url: @server + "/advertisements",
                                          :headers => {:authorization => "Bearer #{@token}"} )

  puts response

end

def get_advert
  sign_in
  response = RestClient::Request.execute( method: :get,
                                          url: @server + "/advertisements/5",
                                          :headers => {:authorization => "Bearer #{@token}"} )

  puts response

end

def create_advert
  sign_in
  begin
  response = RestClient::Request.execute( method: :post,
                                          url: @server + "/advertisements",
                                          payload: {
                                            
                                              title: "s",
                                              description: "Sell BMV",
                                              status: "created"
                                            },
                                          headers: {:authorization => "Bearer #{@token}"} )


  rescue RestClient::ExceptionWithResponse => err
    puts err.response
  end
  puts response
end

def update_advert
  sign_in
  
  response = RestClient::Request.execute( method: :patch,
                                          url: @server + "/advertisements/4",
                                          payload: {
                                            
                                              title: "sell car",
                                              description: "Sell BMV"
                                            },
                                          headers: {:authorization => "Bearer #{@token}"} )

  puts response
end


def delete_advert
  sign_in

  response = RestClient::Request.execute( method: :delete,
                                          url: @server + "/advertisements/7",
                                          :headers => {:authorization => "Bearer #{@token}"} )


  puts response
end
