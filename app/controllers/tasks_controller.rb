class TasksController < ApplicationController
  get '/tasks' do
    tasks = Task.all
    erb :"tasks/index.html", locals: { tasks: Task.all }

  end

  get '/tasks/new' do
    tasks = Task.all
    erb :"tasks/new.html", locals: { tasks: Task.all }
  end

  post '/tasks' do
    task = Task.new(description: params[:description])
    if task.save
      redirect "/"
    else
      flash[:error] = "Description can't be blank"
      redirect "/tasks/new"
    end
  end



  get '/tasks/:id' do
    task = Task.find_by(id: params['id'])
    erb :"tasks/edit.html", locals: {description: task.description, id: params['id']} 
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
