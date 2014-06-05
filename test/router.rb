#!/usr/bin/env ruby
require 'minitest/autorun'
require 'pry'
require 'pry-nav'
require File.join(File.expand_path("../", __FILE__), 'test_helper')

class TestRouter < MiniTest::Unit::TestCase
  def test_url_reg_exp
    r = Nails::Router.new
    url = "user/:user_id/post/:post_id"
    url_reg_exp = r.url_reg_exp(url)
    assert url_reg_exp == '\Auser/(?<user_id>\d+)/post/(?<post_id>\d+)\z'
  end

  def test_get
    r = Nails::Router.new
    route = "post/:post_id"
    route_table = r.get(route, {to: "post#show"})
    assert route_table == [["get", '\Apost/(?<post_id>\d+)\z', 'post', 'show']]
  end

  def test_route
    r = Nails::Router.new
    route = "post/:post_id"
    route_table = r.get(route, {to: "post#show"})
    url = 'post/7'
    assert r.route(url, "get", {}) == ["post", "show", {"post_id"=>"7"}]
  end

  def test_post_route_with_params
    r = Nails::Router.new
    route = "post"
    route_table = r.post(route, {to: "post#create"})
    url = 'post'
    params = {"user_id"=>"1", "message"=>"First Post!"}
    puts r.route(url, "post", params) 
    assert r.route(url, "post", params) == ["post", "create", params]
  end

end