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
                                             email: "admin@gmail.com",
                                             password: "Qwerty123"
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

def show_user
  sign_in
  response = RestClient::Request.execute(method: :get,
                                         url: @server + "/users/43",
                                         headers: {:authorization => "Bearer #{@token}"}
  )
  puts response

end

def update_user
  response = RestClient::Request.execute(method: :patch,
                                         url: @server + "/users/43",
                                         payload: {
                                             email: "noname@mail.com",
                                             password: "Qwerty123",
                                             role_id: 1
                                         },
                                         headers: {:authorization => "Bearer #{@token}"},

  )

  puts response
end

def delete_user
  sign_in
  response = RestClient::Request.execute(method: :delete,
                                         url: @server + "/users/9",
                                         headers: {:authorization => "Bearer #{@token}"}
  )
  puts response

end