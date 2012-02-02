require 'sinatra'
require 'json'

reg = [:auth_token, :type, :device_id]
post_req = [:auth_token, :time]
active = [:auth_token]
update_post = [:auth_token, :time, :loc, :friends_going, :close]

def verify_all_exist(requirements, keys)
  requirements.map do |r|
    return false if keys[r].nil?
  end
  true
end

def type_match(type)
  type == 'iphone' or type == 'android'
end

def is_time(time)
  return time.to_i > 0
end

get '/register_device' do
  if verify_all_exist(reg, params) and type_match(params[:type])
    "{code:'success'}"
  else
    "{code:'fail'}"
  end
end

get '/post' do
  if verify_all_exist(post_req, params) and is_time(params[:time])
    "{code:'success'}"
  else
    "{code:'fail'}"
  end
end

get '/active_friends' do
  if verify_all_exist(active, params)
     {:friends => [
       { :name => 'Andrew Purcell', :id => '123456789', 
         :time_end => 'Thu Feb 02 2012 02:15:59 GMT-0500 (EST)', 
         :fb_pic_src => 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/369468_1086720750_1179575572_q.jpg', 
         :loc => 'Anna\'s Taqueria', :others => [{name:'Erik Formella', id:'9876544'},
                                                 {name:'Hershal Dave', id:'12324545'}]},
       { :name => 'Jesse Weeks', :id => '123456789', 
         :time_end => 'Thu Feb 02 2012 02:15:59 GMT-0500 (EST', 
         :fb_pic_src => 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/369468_1086720750_1179575572_q.jpg', 
         :loc => 'Table alone in Dewick', :others => []}
      ]}.to_json
  else
    "{code:'fail'}"
  end
end