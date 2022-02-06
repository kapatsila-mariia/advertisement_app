require 'rubygems'
require 'rest-client'
require 'json'

@server = "http://127.0.0.1:3000"

def sign_up
  begin
    response = RestClient::Request.execute( method: :post,
                                            url: @server + "/users",
                                            payload: {
                                              user:{
                                                email: "kira3@user.com",
                                                password: "Qwerty123",
                                                login: "kira3",
                                                role_id: 1
                                              }
                                            }
    )
  rescue RestClient::ExceptionWithResponse => err
    puts err.response
  end
  
  puts response 
end

def sign_in

  response = RestClient::Request.execute(method: :post,
                                         url: @server + "/users/sign_in",
                                         payload: {
                                           user:{
                                             email: "nick1@user.com",
                                             password: "123456"
                                           }
                                         }
  )

  puts response
  @token = response
  
end

def sign_out
  sign_in
  response = RestClient::Request.execute(method: :delete,
                                         url: @server + "/users/sign_out",
                                         headers: {:authorization => "Bearer #{@token}"}
  )
  puts response

end
