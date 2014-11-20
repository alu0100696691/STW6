# -*- coding: utf-8 -*-
require 'coveralls'            
Coveralls.wear!
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'sinatra'
require 'selenium-webdriver'
require 'rubygems'

include Rack::Test::Methods

def app
	Sinatra::Application
end


describe "test selenium pagina registro" do
	before :all do
		@browser = Selenium::WebDriver.for :firefox
		@url = 'https://chatstw6.herokuapp.com/'
		if (ARGV[0].to_s == "localhost")
			@url = 'localhost:4567/'
		end
		@browser.get(@url)
	end
	
		it "se abre pagina de Registro?" do
		begin
			element = @browser.find_element(:id,"login")
		ensure
			element = element.text.to_s
			assert_equal(true, element.include?("Sign In"))
			@browser.quit
		end
	end

	it "registrar un nuevo usuario" do
		@browser.find_element(:id,"nombre").send_keys("ana")
		begin
			element = @browser.find_element(:id,"login")
		ensure
			element.click
			assert_equal("https://chatstw6.herokuapp.com/index",@browser.current_url)
			@browser.quit
		end

	end
	
	it "el nuevo usuario ya existe" do
		@browser.find_element(:id,"nombre").send_keys("ana")
                begin
                        element = @browser.find_element(:id,"login")
                ensure
                        element.click
			flash = @browser.find_element(:id,"aviso").text
			assert_equal("Ese nombre ya existe, por favor, prueba con otro nombre.", flash)
			@browser.quit
                end

        end


end



describe "test selenium pagina home" do
        before :all do
                @browser = Selenium::WebDriver.for :firefox
		@url = 'https://chatstw6.herokuapp.com/'
                if (ARGV[0].to_s == "localhost")
                        @url = 'localhost:4567/'
                end
                @browser.get(@url)

		@wait = Selenium::WebDriver::Wait.new(:timeout => 5)
        end

	after :all do
		@browser.quit
	end
        
	it "se abre pagina de home?" do
        	@browser.find_element(:id,"nombre").send_keys("luis")
                begin
                        element = @browser.find_element(:id,"login")
                ensure
                        element.click
                        assert_equal("https://chatstw6.herokuapp.com/index",@browser.current_url)
                end
	end
	
	it "se actualiza el chat con nuevos comentarios?" do
                begin
                        @browser.find_element(:id,"nombre").send_keys("juan")
			@browser.find_element(:id,"login").click
                ensure
			element = @browser.find_element(:id,"text")
			element.send_keys("yuhu")
			element.send_keys:return
			chat = @browser.find_element(:id,"chat").text
			puts chat
			assert_equal("",chat)
		end
	end
end
