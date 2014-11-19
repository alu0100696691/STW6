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
                session[:usuario] = params[:nombre]
                usuarios.push session[:usuario]
                @listaUsuarios = usuarios
                erb :index
        else
                flash[:error] = "Ese nombre ya existe, por favor, prueba con otro nombre."
                redirect '/'
        end

end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:usuario]} : #{params['text']}"
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

get '/update/usuarios' do
        return [404, {}, "Not an ajax request"] unless request.xhr?
        @listaUsuarios = usuarios
                erb <<-'HTML', :layout => false
                        <ol>    
                                <% @listaUsuarios.each do |user| %>
                                        <li id="col" class="bg-primary"><%= user %><br></li>
                                <% end %>
                        </ol>                               
                HTML
end

get '/salir' do
        usuarios.delete_if { |element| element == session[:usuario]}
        session.clear
        redirect '/'

end

get '/limpiar' do
	usuarios.clear
	chat.clear
	@listaUsuarios = usuarios
	redirect '/'
end
