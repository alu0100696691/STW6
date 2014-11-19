# -*- coding: utf-8 -*-
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'minitest/autorun'
require 'rack/test'
require 'sinatra'
require 'selenium-webdriver'
require 'rubygems'

describe "test selenium pagina registro" do
	before :all do
		@browser = Selenium::WebDriver.for :firefox
		@url = 'localhost:4567/'
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
			assert_equal("http://localhost:4567/index",@browser.current_url)
			@browser.quit
		end

	end
	
	it "el nuevo usuario ya existe" do
		@browser.find_element(:id,"nombre").send_keys("ana")
                begin
                        element = @browser.find_element(:id,"login")
                ensure
                        element.click
			flash = @browser.find_element(:id,"divAviso").find_element(:id,"aviso").text.to_s
			assert_equal(false, flash.include?("Ese nombre ya existe, por favor, prueba con otro nombre."))
			@browser.quit
                end

        end


end

describe "test selenium pagina home" do
        before :all do
                @browser = Selenium::WebDriver.for :firefox
                @url = 'localhost:4567/'
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
                        assert_equal("http://localhost:4567/index",@browser.current_url)
                end
	end

	it "se actualiza el chat con nuevos comentarios?" do
                begin
                        @browser.find_element(:id,"nombre").send_keys("juan")
			@browser.find_element(:id,"login").click
			@wait.until { @browser.find_element(:id,"text").send_keys("hola") }
			element = @wait.until { @browser.find_element(:id,"enviar") }
			chat = @wait.until { @browser.find_element(:id,"chat") }
                ensure
                        element.click
			chat = chat.text.to_s
			assert_equal(false, chat.include?("juan : hola"))
		end
	end
end
