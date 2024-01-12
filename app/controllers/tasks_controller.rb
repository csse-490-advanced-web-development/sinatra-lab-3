class TasksController < ApplicationController
  get '/tasks' do
    tasks = Task.all
    erb :"tasks/index.html", locals: {tasks: tasks}
  end

  get '/task/new' do
    erb :"tasks/new.html"
  end

  post '/tasks' do
    task = Task.new(description: params[:description])
    if task.save
      redirect "/"
    else
      flash[:error] = "Description can't be blank"
      redirect "/task/new"
    end 
  end

  get '/tasks/:id' do
    erb :"tasks/edit.html", locals: {description: Task.find_by(id: params['id']).description, id: params['id']}
  end

  put '/tasks' do
    task = Task.find_by(id: params['id'])
    task.description = params[:description]
    if task.save
      redirect "/"
    else
      flash[:error] = "Description can't be blank"
      redirect "/tasks/#{params[:id]}"
    end 
  end

  delete '/tasks' do
    task = Task.find_by(id: params['id'])
    task.destroy!
    redirect "/"
  end
end
