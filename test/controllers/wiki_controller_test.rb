# frozen_string_literal: true

require 'test_helper'

class WikiControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get wiki_index_url
    assert_response :success
  end

  test 'should get show' do
    get wiki_show_url
    assert_response :success
  end

  test 'should get new' do
    get wiki_new_url
    assert_response :success
  end

  test 'should get create' do
    get wiki_create_url
    assert_response :success
  end

  test 'should get edit' do
    get wiki_edit_url
    assert_response :success
  end

  test 'should get update' do
    get wiki_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get wiki_destroy_url
    assert_response :success
  end
end
