class TasksController < ApplicationController
  get '/tasks' do
    tasks = Task.all
    erb :"tasks/index.html", locals: {tasks: tasks}
  end

  get '/tasks/new' do
    erb :"tasks/new.html"
  end




  post '/tasks' do
    task = Task.new(description: params[:description])
    task.save!
    redirect "/"
  end
end
