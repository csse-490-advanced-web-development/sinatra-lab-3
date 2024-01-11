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

    # Step 33: Modify the code above so that it uses an if/else statement to
    #          react to the task being valid/invalid.  You should render the 'new'
    #          form again if the data can't be saved.
    #
    #          NOTE: `task.save!` raises an error if the record can't be saved.
    #                 Switching to `task.save` returns a boolean that you can
    #                 use in the if/else statement
    #
    # Step 35: We will use `sinatra-flash` (https://github.com/SFEley/sinatra-flash)
    #          to add a message to our output. e.g. `flash.now[:errors] = ...`
    #          where ... is the full error message.  See the code sample here for
    #          an example of getting full error messages:
    #          https://guides.rubyonrails.org/active_record_validations.html#working-with-validation-errors-errors
  end

  # Step 38+:
  #   * You're going to have to add to this controller so that you can accept GET requests to e.g. `/tasks/4` (to render the edit form)
  #   * You will use route params (see: https://sinatrarb.com/intro.html#routes) for this.
  #   * You will also have to add to this controller so that you can accept PUT requests to e.g. `/tasks/4` (to save updates to the tasks)
  #   * This will give you some good hints on hooking everything together!: https://gist.github.com/victorwhy/45bb5637cd3e7e879ace
  #   * To delete a task: `task.destroy!`
end
