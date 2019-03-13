
require_relative '../../config/environment'

set :method_override, true

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles'
  end

  #index (read all)
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  #new
  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  #create
  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
  end

  #read by id
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  #edit article
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  #update article
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  #delete
  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect to '/'
  end


end
