require 'test_helper'

    class ArticleTest < ActiveSupport::TestCase

        #--------------Start Test Relation--------------

        test "Get all comment for first article" do

            article = Article.first

            assert article.comments

        end


        test "Get article from first comment" do

            comment = Comment.first

            assert comment.article

        end


        #---------------Start Test validation----------------

        # **********when save data**********

        test "create article with invalid, title is blank" do

            article = Article.new(title: "", content: "lorem ipsum heroda kara",status: "active")

            assert_equal false, article.valid?

            assert_not article.save

        end


        test "create article with invalid data, title < 5" do

            article = Article.new(title: "abcd", content: "lorem ipsum heroda kara",status: "active")

            assert_equal false, article.valid?

            assert_not article.save

        end


        test "create article with invalid data, content is blank" do

            article = Article.new(title: "learn uni test", content: "",status: "active")

            assert_equal false, article.valid?

            assert_not article.save

        end


        test "create article with invalid data, content < 10" do

            article = Article.new(title: "learn uni test", content: "abcde fg",status: "active")

            assert_equal false, article.valid?

            assert_not article.save

        end


        test "create article with invalid data, status is blank" do

            article = Article.new(title: "learn unit test", content: "conten of article learn unit test",status: "")

            assert_equal false, article.valid?

            assert_not article.save

        end


        # test "create article with valid data" do

        #     article = Article.new(:title => "Testing", :content => "This is body", status: 'active')

        #     assert_equal true, article.valid?

        #     assert_not article.save

        # end


        # **********when edit data************

        test "edit article with invalid, title is blank" do

            article = Article.first

            assert_equal false, article.update(title: "", content: "lorem ipsum heroda kara",status: "active")

        end


        test "edit article with invalid data, title < 5" do

            article = Article.first

      assert_equal false, article.update(title: "abcd", content: "lorem ipsum heroda kara",status: "active")

        end


        test "edit article with invalid data, content is blank" do

            article = Article.first

            assert_equal false, article.update(title: "learn uni test", content: "",status: "active")

        end


        test "edit article with invalid data, content < 10" do

            article = Article.first

            assert_equal false, article.update(title: "learn uni test", content: "abcde fg",status: "active")

        end


        test "edit article with invalid data, status is blank" do

            article = Article.first

            assert_equal false, article.update(title: "learn unit test", content: "conten of article learn unit test",status: "")

        end


        test "edit article with valid data" do

            article = Article.first

            assert_equal true, article.update(title: "Edit Testing", content: "Edit This is body")

        end

        #----------------End Test Validation-----------------


        #--------------Test custom Scope-----------------

        test "check scope, data exist if status active" do

            assert Article.status_active

        end

    end