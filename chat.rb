require 'sinatra' 
require 'sinatra/reloader' if development?
require 'sinatra/flash'
#set :port, 3000
#set :environment, :production

enable :sessions
set :session_secret, '*&(^#234a)'



chat = ['welcome..']
usuarios = Array.new
@listaUsuarios = []


get '/' do 
        erb :registro
end

post '/index' do
	puts "inside post '/index/': #{params}"
        if !usuarios.include?(params[:nombre]) then
                session[:nombre] = params[:nombre]
                usuarios.push session[:nombre]
                @listaUsuarios = usuarios
                erb :index
        else
                flash[:error] = "Ese nombre ya existe, por favor, prueba con otro nombre de usuario."
                redirect '/'
        end

end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:nombre]} : #{params['text']}"
  nil
end

get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []

  @last = chat.size
  erb <<-'HTML', :layout => false
      <% @updates.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
      <span data-last="<%= @last %>"></span>
  HTML
end

