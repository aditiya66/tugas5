 require 'test_helper'

    class ArticlesControllerTest < ActionController::TestCase

        # def setup will call before every test

        # this function for create session

        def setup

            create_session "develror@gmail.com"

        end


        test "index should render correct template" do

            get :index

            assert_response :success

            assert_template :index

            assert_template layout: "layouts/application"

        end


        test "should response 200 and render to new page" do

            get :new

            assert_response :success

            assert_template :new

            assert_template layout: "layouts/application"

        end


        test "should create article and send flash success " do

            post :create, article: {title: 'test controller title', content: 'test controller content', status: 'active'}

            assert_response :redirect

            assert_redirected_to root_path

            assert_equal "Success Add Records", flash[:notice]

        end


        test "should response 200 and render page show" do

            get :show, id: Article.first.id

            assert_response :success

            assert_template :show

        end


        test "should response 200 and render to edit page" do

            get :edit, id: Article.first.id

            assert_response :success

            assert_template :edit

        end


        test "should update article and send flash success " do

            patch :update, id: Article.first.id, article: {title: 'edit test controller title', content: 'edit test controller content'}

            assert_response :redirect

            assert_redirected_to root_path

            assert_equal "Success Update Records", flash[:notice]

        end


        private

            def create_session(email)

                user = User.find_by_email(email)

                session[:user] = user.id unless user.nil?

            end

    end

