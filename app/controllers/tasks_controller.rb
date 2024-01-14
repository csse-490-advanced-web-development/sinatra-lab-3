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
    if not task.save then
      flash[:errors] = task.errors.full_messages.join(", ")
      redirect "/tasks/new"
    end
    redirect "/"
  end

  get '/tasks/:id' do |id|
    task = Task.find(id)
    erb :"tasks/edit.html", locals: {task: task}
  end

  put '/tasks/:id' do |id|
    task = Task.find(id)
    task.description = params[:description]
    if not task.save then
      flash[:errors] = task.errors.full_messages.join(", ")
      redirect "/tasks/#{id}"
    end
    redirect "/"
  end

  delete '/tasks/:id' do |id|
    task = Task.find(id)
    task.destroy!
    redirect "/"
  end
end
