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

  # Step 38+:
  #   * You're going to have to add to this controller so that you can accept GET requests to e.g. `/tasks/4` (to render the edit form)
  #   * You will use route params (see: https://sinatrarb.com/intro.html#routes) for this.
  #   * You will also have to add to this controller so that you can accept PUT requests to e.g. `/tasks/4` (to save updates to the tasks)
  #   * This will give you some good hints on hooking everything together!: https://gist.github.com/victorwhy/45bb5637cd3e7e879ace
  #   * To delete a task: `task.destroy!`

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
