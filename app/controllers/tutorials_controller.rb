class TutorialsController < ApplicationController
  before_action :set_tutorial, only: %i[ show edit update destroy ]

  def index
    @tutorials = Tutorial.paginate(page: params[:page], per_page: 9)
  end

  def show
    if @tutorial.image_link.nil?
      name = "#{current_user.email}" + "#{rand(1..1000)}.png"
      screenshot = Gastly.capture("#{@tutorial.link}", "./app/assets/images/#{name}")
      @tutorial.update_attribute(:image_link, name)
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def edit
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)

    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to tutorial_url(@tutorial), notice: "Tutorial was successfully created." }
        format.json { render :show, status: :created, location: @tutorial }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tutorial.update(tutorial_params)
        format.html { redirect_to tutorial_url(@tutorial), notice: "Tutorial was successfully updated." }
        format.json { render :show, status: :ok, location: @tutorial }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tutorial.destroy

    respond_to do |format|
      format.html { redirect_to tutorials_url, notice: "Tutorial was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_tutorial
    @tutorial = Tutorial.find(params[:id])
  end

  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :user_id, :link, :image_link)
  end
end
