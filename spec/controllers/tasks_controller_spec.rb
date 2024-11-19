require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) { { title: "Test Task", completed: false } }
  let(:invalid_attributes) { { title: "", completed: false } }
  let(:task) { Task.create!(valid_attributes) }

  describe "GET #index" do
    it "returns a success response" do
      Task.create!(valid_attributes)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: task.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post :create, params: { task: valid_attributes }
        expect(response).to redirect_to(Task.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post :create, params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders the 'new' template" do
        post :create, params: { task: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: task.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      let(:new_attributes) { { title: "Updated Task", completed: true } }

      it "updates the requested task" do
        patch :update, params: { id: task.id, task: new_attributes }
        task.reload
        expect(task.title).to eq("Updated Task")
        expect(task.completed).to be(true)
      end

      it "redirects to the task" do
        patch :update, params: { id: task.id, task: new_attributes }
        expect(response).to redirect_to(task)
      end
    end

    context "with invalid parameters" do
      it "does not update the task" do
        patch :update, params: { id: task.id, task: invalid_attributes }
        task.reload
        expect(task.title).not_to eq("")
      end

      it "renders the 'edit' template" do
        patch :update, params: { id: task.id, task: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task_to_destroy = Task.create!(valid_attributes)
      expect {
        delete :destroy, params: { id: task_to_destroy.id }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task_to_destroy = Task.create!(valid_attributes)
      delete :destroy, params: { id: task_to_destroy.id }
      expect(response).to redirect_to(tasks_url)
    end
  end
end
