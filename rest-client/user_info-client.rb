require 'rubygems'
require 'rest-client'
require_relative 'user-client'


def get_info
  sign_in
  response = RestClient::Request.execute( method: :get,
                                          url: @server + "/users_info",
                                          :headers => {:authorization => "Bearer #{@token}"} )

  puts response

end

def create_info
  sign_in
  begin
  response = RestClient::Request.execute( method: :post,
                                          url: @server + "/users_info",
                                          payload: {

                                            first_name: "Lola",
                                            last_name: "Lu",
                                            phone: "380"
                                          },
                                          headers: {:authorization => "Bearer #{@token}"} )


  rescue RestClient::ExceptionWithResponse => err
    puts err.response
  end
  puts response
end

def update_info
  sign_in

  response = RestClient::Request.execute( method: :patch,
                                          url: @server + "/users_info",
                                          payload: {

                                            first_name: "Lola",
                                            last_name: "Lui",
                                            phone: "38098746587"
                                          },
                                          headers: {:authorization => "Bearer #{@token}"} )


  puts response
end

def delete_info
  sign_in

  response = RestClient::Request.execute( method: :delete,
                                          url: @server + "/users_info",
                                          :headers => {:authorization => "Bearer #{@token}"} )


  puts response
end

